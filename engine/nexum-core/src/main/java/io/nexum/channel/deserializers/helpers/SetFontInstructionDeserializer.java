package io.nexum.channel.deserializers.helpers;

import io.nexum.core.services.HelperDeserializerService;
import io.nexum.channel.FriendlyBuffer;
import io.nexum.channel.HelperDeserializer;
import io.nexum.render.instructions.SetFontInstruction;
import org.jetbrains.annotations.NotNull;

import java.awt.*;

public class SetFontInstructionDeserializer implements HelperDeserializer<SetFontInstruction> {
    @Override
    public @NotNull SetFontInstruction deserialize(@NotNull FriendlyBuffer friendlyBuffer) {
        final Font font = HelperDeserializerService.getInstance().deserialize(friendlyBuffer);
        return new SetFontInstruction(font);
    }

    @Override
    public @NotNull String getIdentifier() {
        return "set_font";
    }

    @Override
    public @NotNull Class<SetFontInstruction> getObjectClazz() {
        return SetFontInstruction.class;
    }
}
