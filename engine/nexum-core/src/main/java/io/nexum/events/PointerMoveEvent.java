package io.nexum.events;

import io.nexum.models.Offset;
import org.jetbrains.annotations.NotNull;

public class PointerMoveEvent extends PointerEvent {
    public PointerMoveEvent(@NotNull Offset position) {
        super(position);
    }
}
