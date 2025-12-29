package io.nexum.channel.handlers;

import io.nexum.Nexum;
import io.nexum.channel.PacketHandler;
import io.nexum.channel.packets.SendGraphicsPacket;
import org.jetbrains.annotations.NotNull;

public class SendGraphicsPacketHandler implements PacketHandler<SendGraphicsPacket> {
    @Override
    public void handle(@NotNull SendGraphicsPacket packet) {
        Nexum.getInstance().render(packet.getConsumer());
    }

    @Override
    public @NotNull Class<SendGraphicsPacket> getPacketClazz() {
        return SendGraphicsPacket.class;
    }
}
