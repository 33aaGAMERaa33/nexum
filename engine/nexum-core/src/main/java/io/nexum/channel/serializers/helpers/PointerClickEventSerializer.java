package io.nexum.channel.serializers.helpers;

import io.nexum.services.HelperSerializerService;
import io.nexum.events.PointerClickEvent;
import io.nexum.channel.FriendlyBuffer;
import io.nexum.channel.HelperSerializer;
import org.jetbrains.annotations.NotNull;

public class PointerClickEventSerializer implements HelperSerializer<PointerClickEvent> {
    @Override
    public void serialize(@NotNull PointerClickEvent object, @NotNull FriendlyBuffer friendlyBuffer) {
        HelperSerializerService.getInstance().serialize(object.getPosition(), friendlyBuffer);
        friendlyBuffer.writeBool(object.isReleased());
    }

    @Override
    public @NotNull String getIdentifier() {
        return "pointer_click";
    }

    @Override
    public @NotNull Class<PointerClickEvent> getObjectClazz() {
        return PointerClickEvent.class;
    }
}
