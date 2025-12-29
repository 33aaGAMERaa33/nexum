package io.nexum.channel;

import org.jetbrains.annotations.NotNull;

public interface PacketSerializer<T extends Packet> {
    void serialize(@NotNull T packet, @NotNull FriendlyBuffer friendlyBuffer);
    @NotNull String getIdentifier();
    @NotNull Class<T> getPacketClazz();
}
