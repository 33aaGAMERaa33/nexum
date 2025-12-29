package io.nexum.channel.serializers.helpers;

import io.nexum.core.services.HelperSerializerService;
import io.nexum.events.PointerMoveEvent;
import io.nexum.channel.FriendlyBuffer;
import io.nexum.channel.HelperSerializer;
import org.jetbrains.annotations.NotNull;

public class PointerMoveEventSerializer implements HelperSerializer<PointerMoveEvent> {
    @Override
    public void serialize(@NotNull PointerMoveEvent object, @NotNull FriendlyBuffer friendlyBuffer) {
        HelperSerializerService.getInstance().serialize(object.getPosition(), friendlyBuffer);
    }

    @Override
    public @NotNull String getIdentifier() {
        return "pointer_move";
    }

    @Override
    public @NotNull Class<PointerMoveEvent> getObjectClazz() {
        return PointerMoveEvent.class;
    }
}
