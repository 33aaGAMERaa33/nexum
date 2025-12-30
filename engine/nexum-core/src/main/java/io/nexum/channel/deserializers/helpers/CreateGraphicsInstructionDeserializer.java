package io.nexum.channel.deserializers.helpers;

import io.nexum.services.HelperDeserializerService;
import io.nexum.channel.FriendlyBuffer;
import io.nexum.channel.HelperDeserializer;
import io.nexum.render.RenderContextConsumer;
import io.nexum.render.instructions.CreateSubContextInstruction;
import org.jetbrains.annotations.NotNull;

public class CreateGraphicsInstructionDeserializer implements HelperDeserializer<CreateSubContextInstruction> {
    @Override
    public @NotNull CreateSubContextInstruction deserialize(@NotNull FriendlyBuffer friendlyBuffer) {
        final RenderContextConsumer consumer = HelperDeserializerService.getInstance().deserialize(friendlyBuffer);
        return new CreateSubContextInstruction(consumer);
    }

    @Override
    public @NotNull String getIdentifier() {
        return "create_sub_context";
    }

    @Override
    public @NotNull Class<CreateSubContextInstruction> getObjectClazz() {
        return CreateSubContextInstruction.class;
    }
}
