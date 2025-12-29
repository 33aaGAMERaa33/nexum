package io.nexum.channel.deserializers.helpers;

import io.nexum.channel.FriendlyBuffer;
import io.nexum.channel.HelperDeserializer;
import io.nexum.models.Size;
import org.jetbrains.annotations.NotNull;

public class SizeDeserializer implements HelperDeserializer<Size> {
    @Override
    public @NotNull Size deserialize(@NotNull FriendlyBuffer friendlyBuffer) {
        final int height = friendlyBuffer.readInt();
        final int width = friendlyBuffer.readInt();

        return new Size(width, height);
    }

    @Override
    public @NotNull String getIdentifier() {
        return "size";
    }

    @Override
    public @NotNull Class<Size> getObjectClazz() {
        return Size.class;
    }
}
