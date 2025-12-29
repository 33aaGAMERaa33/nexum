package io.nexum.channel.packets;

import io.nexum.channel.Packet;
import io.nexum.render.RenderContextConsumer;
import org.jetbrains.annotations.NotNull;

public class SendGraphicsPacket extends Packet {
    private final @NotNull RenderContextConsumer consumer;

    public SendGraphicsPacket(@NotNull RenderContextConsumer consumer) {
        this.consumer = consumer;
    }

    public @NotNull RenderContextConsumer getConsumer() {
        return consumer;
    }
}
