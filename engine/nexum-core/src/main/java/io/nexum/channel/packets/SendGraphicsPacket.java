package io.nexum.channel.packets;

import io.nexum.channel.Packet;
import io.nexum.render.GraphicsInstructionsConsumer;
import org.jetbrains.annotations.NotNull;

public class SendGraphicsPacket extends Packet {
    private final @NotNull GraphicsInstructionsConsumer consumer;

    public SendGraphicsPacket(@NotNull GraphicsInstructionsConsumer consumer) {
        this.consumer = consumer;
    }

    public @NotNull GraphicsInstructionsConsumer getConsumer() {
        return consumer;
    }
}
