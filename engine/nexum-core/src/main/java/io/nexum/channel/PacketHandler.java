package io.nexum.channel;

import org.jetbrains.annotations.NotNull;

public interface PacketHandler<T extends Packet> {
    void handle(@NotNull T packet);
    @NotNull Class<T> getPacketClazz();
}
