package io.nexum.channel.deserializers.helpers;

import io.nexum.core.services.HelperDeserializerService;
import io.nexum.channel.FriendlyBuffer;
import io.nexum.channel.HelperDeserializer;
import io.nexum.render.GraphicsInstruction;
import io.nexum.render.GraphicsInstructionsConsumer;
import org.jetbrains.annotations.NotNull;

public class GraphicsInstructionsConsumerDeserializer implements HelperDeserializer<GraphicsInstructionsConsumer> {
    @Override
    public @NotNull GraphicsInstructionsConsumer deserialize(@NotNull FriendlyBuffer friendlyBuffer) {;
        final GraphicsInstructionsConsumer consumer = new GraphicsInstructionsConsumer();
        final int instructionsSize = friendlyBuffer.readInt();

        for(int i = 0; i < instructionsSize; i++) {
            final GraphicsInstruction instruction = HelperDeserializerService.getInstance().deserialize(friendlyBuffer);
            consumer.addInstruction(instruction);
        }

        return consumer;
    }

    @Override
    public @NotNull String getIdentifier() {
        return "graphics";
    }

    @Override
    public @NotNull Class<GraphicsInstructionsConsumer> getObjectClazz() {
        return GraphicsInstructionsConsumer.class;
    }
}
