package io.nexum.channel.deserializers.helpers;

import io.nexum.channel.FriendlyBuffer;
import io.nexum.channel.HelperDeserializer;
import org.jetbrains.annotations.NotNull;

import java.awt.*;

public class FontDeserializer implements HelperDeserializer<Font> {
    @Override
    public @NotNull Font deserialize(@NotNull FriendlyBuffer friendlyBuffer) {
        final int fontSize = friendlyBuffer.readInt();
        return new Font("Arial", Font.BOLD, fontSize);
    }

    @Override
    public @NotNull String getIdentifier() {
        return "font";
    }

    @Override
    public @NotNull Class<Font> getObjectClazz() {
        return Font.class;
    }
}
