package io.nexum.channel.serializers.helpers;

import io.nexum.channel.FriendlyBuffer;
import io.nexum.channel.HelperSerializer;
import io.nexum.events.KeyboardInputEvent;
import org.jetbrains.annotations.NotNull;

public class KeyboardInputEventSerializer implements HelperSerializer<KeyboardInputEvent> {
    @Override
    public void serialize(@NotNull KeyboardInputEvent object, @NotNull FriendlyBuffer friendlyBuffer) {
        friendlyBuffer.writeInt(object.getKeyCode());
        friendlyBuffer.writeBool(object.isReleased());
    }

    @Override
    public @NotNull String getIdentifier() {
        return "keyboard";
    }

    @Override
    public @NotNull Class<KeyboardInputEvent> getObjectClazz() {
        return KeyboardInputEvent.class;
    }
}
