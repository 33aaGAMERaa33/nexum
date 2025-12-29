package io.nexum.channel.serializers.helpers;

import io.nexum.models.Size;
import io.nexum.channel.FriendlyBuffer;
import io.nexum.channel.HelperSerializer;
import org.jetbrains.annotations.NotNull;

public class SizeSerializer implements HelperSerializer<Size> {
    @Override
    public void serialize(@NotNull Size object, @NotNull FriendlyBuffer friendlyBuffer) {
        friendlyBuffer.writeInt(object.getWidth());
        friendlyBuffer.writeInt(object.getHeight());
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
