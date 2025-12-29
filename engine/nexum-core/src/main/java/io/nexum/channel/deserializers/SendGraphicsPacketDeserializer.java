package io.nexum.channel.deserializers;

import io.nexum.core.services.HelperDeserializerService;
import io.nexum.channel.FriendlyBuffer;
import io.nexum.channel.PacketDeserializer;
import io.nexum.channel.packets.SendGraphicsPacket;
import io.nexum.render.RenderContextConsumer;
import org.jetbrains.annotations.NotNull;

public class SendGraphicsPacketDeserializer implements PacketDeserializer<SendGraphicsPacket> {
    @Override
    public @NotNull SendGraphicsPacket deserialize(@NotNull FriendlyBuffer friendlyBuffer) {
        final RenderContextConsumer consumer = HelperDeserializerService.getInstance().deserialize(friendlyBuffer);
        return new SendGraphicsPacket(consumer);
    }

    @Override
    public @NotNull String getIdentifier() {
        return "send_render_context";
    }

    @Override
    public @NotNull Class<SendGraphicsPacket> getPacketClazz() {
        return SendGraphicsPacket.class;
    }
}
