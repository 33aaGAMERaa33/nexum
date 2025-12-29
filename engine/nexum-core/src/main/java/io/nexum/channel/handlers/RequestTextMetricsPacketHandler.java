package io.nexum.channel.handlers;

import io.nexum.Nexum;
import io.nexum.material.TextMetrics;
import io.nexum.models.Size;
import io.nexum.channel.PacketHandler;
import io.nexum.channel.PacketManager;
import io.nexum.channel.packets.RequestTextMetricsPacket;
import io.nexum.channel.packets.SendTextMetricsPacket;
import org.jetbrains.annotations.NotNull;

import java.awt.*;
import java.awt.image.BufferedImage;

public class RequestTextMetricsPacketHandler implements PacketHandler<RequestTextMetricsPacket> {
    @Override
    public void handle(@NotNull RequestTextMetricsPacket packet) {
        final BufferedImage dummy = new BufferedImage(1, 1, Nexum.getInstance().getImageType());
        final Graphics2D gDummy = dummy.createGraphics();

        gDummy.setFont(new Font("Arial", Font.BOLD, packet.getFontSize()));
        final FontMetrics fontMetrics = gDummy.getFontMetrics();
        gDummy.dispose();

        final TextMetrics textMetrics = new TextMetrics(
                new Size(fontMetrics.stringWidth(packet.getValue()), fontMetrics.getHeight())
        );

        PacketManager.getInstance().sendResponsePacket(
                packet, new SendTextMetricsPacket(textMetrics)
        );
    }

    @Override
    public @NotNull Class<RequestTextMetricsPacket> getPacketClazz() {
        return RequestTextMetricsPacket.class;
    }
}
