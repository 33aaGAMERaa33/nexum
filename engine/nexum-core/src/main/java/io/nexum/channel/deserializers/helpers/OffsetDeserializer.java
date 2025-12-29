package io.nexum.channel.deserializers.helpers;

import io.nexum.models.Offset;
import io.nexum.channel.FriendlyBuffer;
import io.nexum.channel.HelperDeserializer;
import org.jetbrains.annotations.NotNull;

public class OffsetDeserializer implements HelperDeserializer<Offset> {
    @Override
    public @NotNull Offset deserialize(@NotNull FriendlyBuffer friendlyBuffer) {
        final int topPos = friendlyBuffer.readInt();
        final int leftPos = friendlyBuffer.readInt();

        return new Offset(leftPos, topPos);
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
