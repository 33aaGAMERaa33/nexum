package io.nexum.core.services;

import io.nexum.core.storages.PacketSerializerRegistry;
import io.nexum.exceptions.PacketSerializationException;
import io.nexum.channel.FriendlyBuffer;
import io.nexum.channel.Packet;
import io.nexum.channel.PacketSerializer;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import java.util.Objects;

public class PacketSerializerService {
    private static @NotNull PacketSerializerService instance = new PacketSerializerService();

    private PacketSerializerService() {

    }

    public <T extends Packet> @NotNull FriendlyBuffer serializePacket(@NotNull T packet) {
        final FriendlyBuffer friendlyBuffer = new FriendlyBuffer();

        @Nullable
        final PacketSerializer<Packet> packetSerializer = PacketSerializerRegistry.getInstance().get(packet.getClass());

        if(packetSerializer == null) throw new PacketSerializationException(String.format(
                "O serializador para pacote %s não foi encontrado",
                packet.getClass().getSimpleName()
        ));

        packetSerializer.serialize(packet, friendlyBuffer);
        friendlyBuffer.write("packet_uuid", Objects.requireNonNull(packet.getUUID()));
        friendlyBuffer.write("identifier", packetSerializer.getIdentifier());

        return friendlyBuffer;
    }

    public static @NotNull PacketSerializerService getInstance() {
        return instance;
    }
}
