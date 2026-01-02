package io.nexum.channel.handlers;

import io.nexum.Nexum;
import io.nexum.channel.PacketHandler;
import io.nexum.channel.packets.SendRenderContextPacket;
import org.jetbrains.annotations.NotNull;

public class SendGraphicsPacketHandler implements PacketHandler<SendRenderContextPacket> {
    @Override
    public void handle(@NotNull SendRenderContextPacket packet) {
        Nexum.getInstance().render(packet.getConsumer());
    }

    @Override
    public @NotNull Class<SendRenderContextPacket> getPacketClazz() {
        return SendRenderContextPacket.class;
    }
}
