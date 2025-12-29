package io.nexum.channel.deserializers.helpers;

import io.nexum.channel.FriendlyBuffer;
import io.nexum.channel.HelperDeserializer;
import io.nexum.render.instructions.DrawStringInstruction;
import org.jetbrains.annotations.NotNull;

public class DrawStringInstructionDeserializer implements HelperDeserializer<DrawStringInstruction> {
    @Override
    public @NotNull DrawStringInstruction deserialize(@NotNull FriendlyBuffer friendlyBuffer) {
        final String value = friendlyBuffer.readString();
        return new DrawStringInstruction(value);
    }

    @Override
    public @NotNull String getIdentifier() {
        return "draw_string";
    }

    @Override
    public @NotNull Class<DrawStringInstruction> getObjectClazz() {
        return DrawStringInstruction.class;
    }
}
