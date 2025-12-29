package io.nexum.channel.deserializers.helpers;

import io.nexum.core.services.HelperDeserializerService;
import io.nexum.channel.FriendlyBuffer;
import io.nexum.channel.HelperDeserializer;
import io.nexum.render.instructions.SetColorInstruction;
import org.jetbrains.annotations.NotNull;

import java.awt.*;

public class SetColorInstructionDeserializer implements HelperDeserializer<SetColorInstruction> {
    @Override
    public @NotNull SetColorInstruction deserialize(@NotNull FriendlyBuffer friendlyBuffer) {
        final Color color = HelperDeserializerService.getInstance().deserialize(friendlyBuffer);
        return new SetColorInstruction(color);
    }

    @Override
    public @NotNull String getIdentifier() {
        return "set_color";
    }

    @Override
    public @NotNull Class<SetColorInstruction> getObjectClazz() {
        return SetColorInstruction.class;
    }
}
