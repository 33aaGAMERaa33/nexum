package io.nexum.channel;

import io.nexum.channel.deserializers.*;
import io.nexum.channel.deserializers.helpers.*;
import io.nexum.channel.handlers.*;
import io.nexum.channel.serializers.*;
import io.nexum.channel.serializers.helpers.*;
import io.nexum.services.PacketDeserializerService;
import io.nexum.services.PacketHandlerService;
import io.nexum.services.PacketSerializerService;
import io.nexum.exceptions.AlreadyInitialized;
import io.nexum.exceptions.PacketDeserializationException;
import io.nexum.exceptions.PacketHandleException;
import io.nexum.exceptions.PacketSerializationException;
import io.nexum.storages.*;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.function.Consumer;

import static io.nexum.Nexum.LOGGER;

public class PacketManager {
    private static @Nullable PacketManager instance;
    private final Map<UUID, Consumer<? extends Packet>> waitingResponse = new ConcurrentHashMap<>();

    private PacketManager() {
        HelperSerializerRegistry.getInstance().register(new OffsetSerializer());
        HelperSerializerRegistry.getInstance().register(new SizeSerializer());
        HelperSerializerRegistry.getInstance().register(new TestObjectSerializer());
        HelperSerializerRegistry.getInstance().register(new TextMetricsSerializer());
        HelperSerializerRegistry.getInstance().register(new PointerMoveEventSerializer());
        HelperSerializerRegistry.getInstance().register(new PointerScrollEventSerializer());
        HelperSerializerRegistry.getInstance().register(new PointerClickEventSerializer());

        HelperDeserializerRegistry.getInstance().register(new CreateNewContextInstructionDeserializer());
        HelperDeserializerRegistry.getInstance().register(new DrawRectInstructionDeserializer());
        HelperDeserializerRegistry.getInstance().register(new SizeDeserializer());
        HelperDeserializerRegistry.getInstance().register(new OffsetDeserializer());
        HelperDeserializerRegistry.getInstance().register(new ClipRectInstructionDeserializer());
        HelperDeserializerRegistry.getInstance().register(new SetCompositeInstructionDeserializer());
        HelperDeserializerRegistry.getInstance().register(new TranslateInstructionDeserializer());
        HelperDeserializerRegistry.getInstance().register(new FontDeserializer());
        HelperDeserializerRegistry.getInstance().register(new ColorDeserializer());
        HelperDeserializerRegistry.getInstance().register(new TestObjectDeserializer());
        HelperDeserializerRegistry.getInstance().register(new SetFontInstructionDeserializer());
        HelperDeserializerRegistry.getInstance().register(new SetColorInstructionDeserializer());
        HelperDeserializerRegistry.getInstance().register(new DrawStringInstructionDeserializer());
        HelperDeserializerRegistry.getInstance().register(new CreateGraphicsInstructionDeserializer());
        HelperDeserializerRegistry.getInstance().register(new GraphicsInstructionsConsumerDeserializer());

        PacketHandlerRegistry.getInstance().register(new TestPacketHandler());
        PacketHandlerRegistry.getInstance().register(new HeartBeatPacketHandler());
        PacketHandlerRegistry.getInstance().register(new LoggerPacketHandler());
        PacketHandlerRegistry.getInstance().register(new SendGraphicsPacketHandler());
        PacketHandlerRegistry.getInstance().register(new SendGraphicsPacketHandler());
        PacketHandlerRegistry.getInstance().register(new RequestDataSyncPacketHandler());
        PacketHandlerRegistry.getInstance().register(new RequestTextMetricsPacketHandler());

        PacketSerializerRegistry.getInstance().register(new StartStartPacketSerializer());
        PacketSerializerRegistry.getInstance().register(new HeartBeatPacketSerializer());
        PacketSerializerRegistry.getInstance().register(new EventPacketSerializer());
        PacketSerializerRegistry.getInstance().register(new TestPacketSerializer());
        PacketSerializerRegistry.getInstance().register(new SyncDataPacketSerializer());
        PacketSerializerRegistry.getInstance().register(new SendTextMetricsPacketSerializer());

        PacketDeserializerRegistry.getInstance().register(new HeartBeatPacketDeserializer());
        PacketDeserializerRegistry.getInstance().register(new LoggerPacketDeserializer());
        PacketDeserializerRegistry.getInstance().register(new TestPacketDeserializer());
        PacketDeserializerRegistry.getInstance().register(new SendGraphicsPacketDeserializer());
        PacketDeserializerRegistry.getInstance().register(new RequestDataSyncPacketDeserializer());
        PacketDeserializerRegistry.getInstance().register(new RequestTextMetricsPacketDeserializer());
    }

    public void handleReceivedData(@NotNull String data) {
        final FriendlyBuffer friendlyBuffer = FriendlyBuffer.fromData(data);

        try {
            final Packet packet = PacketDeserializerService.getInstance().deserializePacket(friendlyBuffer);
            assert packet.getUUID() != null;

            @SuppressWarnings("unchecked")
            final Consumer<Packet> waitingResponse = (Consumer<Packet>) this.waitingResponse.remove(packet.getUUID());

            if(waitingResponse != null) {
                waitingResponse.accept(packet);
                return;
            }

            try {
                PacketHandlerService.getInstance().handlePacket(packet);
            }catch(PacketHandleException exception) {
                this.warn(exception.getMessage());
            }
        }catch(PacketDeserializationException exception) {
            this.warn(exception.getMessage());
        }
    }

    public void sendPacket(@NotNull Packet packet) {
        if(packet.getUUID() == null) packet.setUUID(UUID.randomUUID());

        final Channel channel = Channel.getInstance();

        try {
            final FriendlyBuffer packetSerialized = PacketSerializerService.getInstance().serializePacket(packet);
            channel.send(packetSerialized.buildData());
        }catch(PacketSerializationException exception) {
            this.warn(exception.getMessage());
        }
    }

    public void sendResponsePacket(
            @NotNull Packet requestPacket,
            @NotNull Packet responsePacket
    ) {
        if(requestPacket.getUUID() == null) {
            this.warn(
                    "Não é possivel enviar um pacote de resposta para o pacote %s pois o UUID não foi encontrado",
                    requestPacket.getClass().getSimpleName()
            );

            return;
        }else if(responsePacket.getUUID() != null) {
            this.warn("Não é possivel enviar o pacote de resposta pois ele já possui UUID");
            return;
        }

        responsePacket.setUUID(requestPacket.getUUID());
        this.sendPacket(responsePacket);
    }

    public <T extends Packet> void sendPacketAndWaitResponse(@NotNull Packet packet, @NotNull Consumer<T> onResponse) {
        this.sendPacket(packet);
        this.waitingResponse.put(packet.getUUID(), onResponse);
    }

    private void debug(@NotNull String log, Object ... args) {
        LOGGER.debug("PacketManager", log, args);
    }

    private void warn(@NotNull String log, Object ... args) {
        LOGGER.warn("PacketManager", log, args);
    }

    public static PacketManager initialize() {
        if(instance != null) throw new AlreadyInitialized("PacketManager já foi inicializado");

        final PacketManager packetManager = new PacketManager();
        instance = packetManager;

        return packetManager;
    }

    public static @NotNull PacketManager getInstance() {
        return Objects.requireNonNull(instance);
    }

    public static boolean isInitialized() {
        return instance != null;
    }
}

