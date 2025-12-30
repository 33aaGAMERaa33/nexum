package io.nexum.channel.deserializers.helpers;

import io.nexum.channel.FriendlyBuffer;
import io.nexum.channel.HelperDeserializer;
import io.nexum.services.HelperDeserializerService;
import io.nexum.models.Size;
import io.nexum.render.instructions.DrawRectInstruction;
import org.jetbrains.annotations.NotNull;

public class DrawRectInstructionDeserializer implements HelperDeserializer<DrawRectInstruction> {
    @Override
    public @NotNull DrawRectInstruction deserialize(@NotNull FriendlyBuffer friendlyBuffer) {
        final Size size = HelperDeserializerService.getInstance().deserialize(friendlyBuffer);

        return new DrawRectInstruction(size);
    }

    @Override
    public @NotNull String getIdentifier() {
        return "draw_rect";
    }

    @Override
    public @NotNull Class<DrawRectInstruction> getObjectClazz() {
        return DrawRectInstruction.class;
    }
}
