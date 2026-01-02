package io.nexum.channel.deserializers;

import io.nexum.render.RenderInstruction;
import io.nexum.services.HelperDeserializerService;
import io.nexum.channel.FriendlyBuffer;
import io.nexum.channel.PacketDeserializer;
import io.nexum.channel.packets.SendRenderContextPacket;
import io.nexum.render.RenderContextConsumer;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import java.util.UUID;

public class SendRenderContextPacketDeserializer implements PacketDeserializer<SendRenderContextPacket> {
    @Override
    public @NotNull SendRenderContextPacket deserialize(@NotNull FriendlyBuffer friendlyBuffer) {
        final int instructionLength = friendlyBuffer.readInt();

        for(int i = 0; i < instructionLength; i ++) {
            final UUID uuid = UUID.fromString(friendlyBuffer.readString());
            @Nullable RenderInstruction instruction = RenderInstruction.fromUUID(uuid);

            if(instruction != null) {
                continue;
            }

            instruction = HelperDeserializerService.getInstance().deserialize(friendlyBuffer);
            instruction.attach(uuid);
        }

        final RenderContextConsumer consumer = HelperDeserializerService.getInstance().deserialize(friendlyBuffer);
        return new SendRenderContextPacket(consumer);
    }

    @Override
    public @NotNull String getIdentifier() {
        return "send_render_context";
    }

    @Override
    public @NotNull Class<SendRenderContextPacket> getPacketClazz() {
        return SendRenderContextPacket.class;
    }
}
