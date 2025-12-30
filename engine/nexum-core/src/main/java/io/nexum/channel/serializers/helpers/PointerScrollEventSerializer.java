package io.nexum.channel.serializers.helpers;

import io.nexum.channel.FriendlyBuffer;
import io.nexum.channel.HelperSerializer;
import io.nexum.events.PointerScrollEvent;
import io.nexum.services.HelperSerializerService;
import org.jetbrains.annotations.NotNull;

public class PointerScrollEventSerializer implements HelperSerializer<PointerScrollEvent> {
    @Override
    public void serialize(@NotNull PointerScrollEvent object, @NotNull FriendlyBuffer friendlyBuffer) {
        friendlyBuffer.writeInt(object.getScrollModifier());
        friendlyBuffer.writeInt(object.getScrollAmount());
        HelperSerializerService.getInstance().serialize(object.getPosition(), friendlyBuffer);
    }

    @Override
    public @NotNull String getIdentifier() {
        return "pointer_scroll";
    }

    @Override
    public @NotNull Class<PointerScrollEvent> getObjectClazz() {
        return PointerScrollEvent.class;
    }
}
