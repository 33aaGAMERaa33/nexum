package io.nexum.channel;

import org.jetbrains.annotations.NotNull;

public interface PacketDeserializer<T extends Packet> {
    @NotNull T deserialize(@NotNull FriendlyBuffer friendlyBuffer);
    @NotNull String getIdentifier();
    @NotNull Class<T> getPacketClazz();
}
