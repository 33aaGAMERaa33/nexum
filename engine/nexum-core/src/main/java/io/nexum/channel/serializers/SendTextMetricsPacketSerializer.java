package io.nexum.channel.serializers;

import io.nexum.core.services.HelperSerializerService;
import io.nexum.channel.FriendlyBuffer;
import io.nexum.channel.PacketSerializer;
import io.nexum.channel.packets.SendTextMetricsPacket;
import org.jetbrains.annotations.NotNull;

public class SendTextMetricsPacketSerializer implements PacketSerializer<SendTextMetricsPacket> {
    @Override
    public void serialize(@NotNull SendTextMetricsPacket packet, @NotNull FriendlyBuffer friendlyBuffer) {
        HelperSerializerService.getInstance().serialize(packet.getTextMetrics(), friendlyBuffer);
    }

    @Override
    public @NotNull String getIdentifier() {
        return "send_text_metrics";
    }

    @Override
    public @NotNull Class<SendTextMetricsPacket> getPacketClazz() {
        return SendTextMetricsPacket.class;
    }
}
