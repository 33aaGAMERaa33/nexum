package io.nexum.channel.deserializers.helpers;

import io.nexum.services.HelperDeserializerService;
import io.nexum.channel.FriendlyBuffer;
import io.nexum.channel.HelperDeserializer;
import io.nexum.render.RenderInstruction;
import io.nexum.render.RenderContextConsumer;
import org.jetbrains.annotations.NotNull;

public class GraphicsInstructionsConsumerDeserializer implements HelperDeserializer<RenderContextConsumer> {
    @Override
    public @NotNull RenderContextConsumer deserialize(@NotNull FriendlyBuffer friendlyBuffer) {;
        final RenderContextConsumer consumer = new RenderContextConsumer();
        final int instructionsSize = friendlyBuffer.readInt();

        for(int i = 0; i < instructionsSize; i++) {
            final RenderInstruction instruction = HelperDeserializerService.getInstance().deserialize(friendlyBuffer);
            consumer.addInstruction(instruction);
        }

        return consumer;
    }

    @Override
    public @NotNull String getIdentifier() {
        return "graphics";
    }

    @Override
    public @NotNull Class<RenderContextConsumer> getObjectClazz() {
        return RenderContextConsumer.class;
    }
}
