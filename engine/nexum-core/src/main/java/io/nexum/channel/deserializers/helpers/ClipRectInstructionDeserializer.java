package io.nexum.channel.deserializers.helpers;

import io.nexum.channel.FriendlyBuffer;
import io.nexum.channel.HelperDeserializer;
import io.nexum.services.HelperDeserializerService;
import io.nexum.models.Offset;
import io.nexum.models.Size;
import io.nexum.render.instructions.ClipRectInstruction;
import org.jetbrains.annotations.NotNull;

public class ClipRectInstructionDeserializer implements HelperDeserializer<ClipRectInstruction> {
    @Override
    public @NotNull ClipRectInstruction deserialize(@NotNull FriendlyBuffer friendlyBuffer) {
        final Offset offset = HelperDeserializerService.getInstance().deserialize(friendlyBuffer);
        final Size size = HelperDeserializerService.getInstance().deserialize(friendlyBuffer);

        return new ClipRectInstruction(offset, size);
    }

    @Override
    public @NotNull String getIdentifier() {
        return "clip_rect";
    }

    @Override
    public @NotNull Class<ClipRectInstruction> getObjectClazz() {
        return ClipRectInstruction.class;
    }
}
