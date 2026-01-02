package io.nexum.services;

import io.nexum.storages.PacketDeserializerRegistry;
import io.nexum.exceptions.PacketDeserializationException;
import io.nexum.channel.FriendlyBuffer;
import io.nexum.channel.Packet;
import io.nexum.channel.PacketDeserializer;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import java.util.UUID;

public class PacketDeserializerService {
    private static @NotNull PacketDeserializerService instance = new PacketDeserializerService();

    private PacketDeserializerService() {

    }

    public <T extends Packet> @NotNull T deserializePacket(@NotNull FriendlyBuffer friendlyBuffer) {
        final String identifier = friendlyBuffer.readString();
        final UUID uuid = UUID.fromString(friendlyBuffer.readString());

        @Nullable
        final PacketDeserializer<Packet> packetDeserializer = PacketDeserializerRegistry.getInstance().get(identifier);

        if(packetDeserializer == null) throw new PacketDeserializationException(
                String.format("O desserializador de identificador %s não foi encontrado", identifier)
        );

        final Packet packet = packetDeserializer.deserialize(friendlyBuffer);

        packet.setUUID(uuid);
        @SuppressWarnings("unchecked")
        final T casted = (T) packet;

        return casted;
    }

    public static @NotNull PacketDeserializerService getInstance() {
        return instance;
    }
}