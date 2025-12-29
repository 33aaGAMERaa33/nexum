package io.nexum.channel.packets;

import io.nexum.material.TextMetrics;
import io.nexum.channel.Packet;
import org.jetbrains.annotations.NotNull;

public class SendTextMetricsPacket extends Packet {
    private final @NotNull TextMetrics textMetrics;

    public SendTextMetricsPacket(@NotNull TextMetrics textMetrics) {
        this.textMetrics = textMetrics;
    }

    public @NotNull TextMetrics getTextMetrics() {
        return textMetrics;
    }
}
