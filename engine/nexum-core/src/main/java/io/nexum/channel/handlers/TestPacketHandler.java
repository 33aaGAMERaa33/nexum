package io.nexum.channel.handlers;

import io.nexum.channel.PacketHandler;
import io.nexum.channel.packets.TestPacket;
import org.jetbrains.annotations.NotNull;

public class TestPacketHandler implements PacketHandler<TestPacket> {
    @Override
    public void handle(@NotNull TestPacket packet) {
        System.out.println(packet.getObject().getMessage());
    }

    @Override
    public @NotNull Class<TestPacket> getPacketClazz() {
        return TestPacket.class;
    }
}
