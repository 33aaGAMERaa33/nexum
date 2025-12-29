package io.nexum.channel.serializers.helpers;

import io.nexum.models.Offset;
import io.nexum.channel.FriendlyBuffer;
import io.nexum.channel.HelperSerializer;
import org.jetbrains.annotations.NotNull;

public class OffsetSerializer implements HelperSerializer<Offset> {
    @Override
    public void serialize(@NotNull Offset object, @NotNull FriendlyBuffer friendlyBuffer) {
        friendlyBuffer.writeInt(object.getLeftPos());
        friendlyBuffer.writeInt(object.getTopPos());
    }

    @Override
    public @NotNull String getIdentifier() {
        return "offset";
    }

    @Override
    public @NotNull Class<Offset> getObjectClazz() {
        return Offset.class;
    }
}
