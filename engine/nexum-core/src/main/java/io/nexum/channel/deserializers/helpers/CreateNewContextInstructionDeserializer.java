package io.nexum.channel.deserializers.helpers;

import io.nexum.channel.FriendlyBuffer;
import io.nexum.channel.HelperDeserializer;
import io.nexum.render.RenderContextConsumer;
import io.nexum.render.instructions.CreateNewContextInstruction;
import io.nexum.services.HelperDeserializerService;
import org.jetbrains.annotations.NotNull;

public class CreateNewContextInstructionDeserializer implements HelperDeserializer<CreateNewContextInstruction> {
    @Override
    public @NotNull CreateNewContextInstruction deserialize(@NotNull FriendlyBuffer friendlyBuffer) {
        final RenderContextConsumer consumer = HelperDeserializerService.getInstance().deserialize(friendlyBuffer);
        return new CreateNewContextInstruction(consumer);
    }

    @Override
    public @NotNull String getIdentifier() {
        return "create_new_context";
    }

    @Override
    public @NotNull Class<CreateNewContextInstruction> getObjectClazz() {
        return CreateNewContextInstruction.class;
    }
}
