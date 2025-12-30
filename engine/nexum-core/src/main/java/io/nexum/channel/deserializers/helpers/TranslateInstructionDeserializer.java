package io.nexum.channel.deserializers.helpers;

import io.nexum.services.HelperDeserializerService;
import io.nexum.models.Offset;
import io.nexum.channel.FriendlyBuffer;
import io.nexum.channel.HelperDeserializer;
import io.nexum.render.instructions.TranslateInstruction;
import org.jetbrains.annotations.NotNull;

public class TranslateInstructionDeserializer implements HelperDeserializer<TranslateInstruction> {
    @Override
    public @NotNull TranslateInstruction deserialize(@NotNull FriendlyBuffer friendlyBuffer) {
        final @NotNull Offset offset = HelperDeserializerService.getInstance().deserialize(friendlyBuffer);
        return new TranslateInstruction(offset);
    }


    @Override
    public @NotNull String getIdentifier() {
        return "translate";
    }

    @Override
    public @NotNull Class<TranslateInstruction> getObjectClazz() {
        return TranslateInstruction.class;
    }
}
