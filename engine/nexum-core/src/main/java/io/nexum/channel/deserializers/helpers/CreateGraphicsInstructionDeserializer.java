package io.nexum.channel.deserializers.helpers;

import io.nexum.core.services.HelperDeserializerService;
import io.nexum.channel.FriendlyBuffer;
import io.nexum.channel.HelperDeserializer;
import io.nexum.render.GraphicsInstructionsConsumer;
import io.nexum.render.instructions.CreateGraphicsInstruction;
import org.jetbrains.annotations.NotNull;

public class CreateGraphicsInstructionDeserializer implements HelperDeserializer<CreateGraphicsInstruction> {
    @Override
    public @NotNull CreateGraphicsInstruction deserialize(@NotNull FriendlyBuffer friendlyBuffer) {
        final GraphicsInstructionsConsumer consumer = HelperDeserializerService.getInstance().deserialize(friendlyBuffer);
        return new CreateGraphicsInstruction(consumer);
    }

    @Override
    public @NotNull String getIdentifier() {
        return "create_graphics";
    }

    @Override
    public @NotNull Class<CreateGraphicsInstruction> getObjectClazz() {
        return CreateGraphicsInstruction.class;
    }
}
