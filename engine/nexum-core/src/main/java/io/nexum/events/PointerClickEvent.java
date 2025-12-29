package io.nexum.events;

import io.nexum.models.Offset;
import org.jetbrains.annotations.NotNull;

public class PointerClickEvent extends PointerEvent {
    private final boolean released;

    public PointerClickEvent(@NotNull Offset position, boolean released) {
        super(position);
        this.released = released;
    }

    public boolean isReleased() {
        return released;
    }
}
