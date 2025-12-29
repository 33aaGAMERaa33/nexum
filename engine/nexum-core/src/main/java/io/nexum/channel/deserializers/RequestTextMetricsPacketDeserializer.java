package io.nexum.channel.deserializers;

import io.nexum.channel.FriendlyBuffer;
import io.nexum.channel.PacketDeserializer;
import io.nexum.channel.packets.RequestTextMetricsPacket;
import org.jetbrains.annotations.NotNull;

public class RequestTextMetricsPacketDeserializer implements PacketDeserializer<RequestTextMetricsPacket> {
    @Override
    public @NotNull RequestTextMetricsPacket deserialize(@NotNull FriendlyBuffer friendlyBuffer) {
        final int fontSize = friendlyBuffer.readInt();
        final String value = friendlyBuffer.readString();

        return new RequestTextMetricsPacket(value, fontSize);
    }

    @Override
    public @NotNull String getIdentifier() {
        return "request_text_metrics";
    }

    @Override
    public @NotNull Class<RequestTextMetricsPacket> getPacketClazz() {
        return RequestTextMetricsPacket.class;
    }
}
