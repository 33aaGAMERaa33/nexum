package io.nexum.channel.deserializers.helpers;

import io.nexum.channel.FriendlyBuffer;
import io.nexum.channel.HelperDeserializer;
import org.jetbrains.annotations.NotNull;

import java.awt.*;

public class ColorDeserializer implements HelperDeserializer<Color> {
    @Override
    public @NotNull Color deserialize(@NotNull FriendlyBuffer friendlyBuffer) {
        final int blue = friendlyBuffer.readInt();
        final int green = friendlyBuffer.readInt();
        final int red = friendlyBuffer.readInt();

        return new Color(red, green, blue);
    }

    @Override
    public @NotNull String getIdentifier() {
        return "color";
    }

    @Override
    public @NotNull Class<Color> getObjectClazz() {
        return Color.class;
    }
}
