package io.nexum.events;

import io.nexum.models.Offset;
import org.jetbrains.annotations.NotNull;

public class PointerScrollEvent extends PointerEvent {
    private final int scrollModifier;
    private final int scrollAmount;

    public PointerScrollEvent(@NotNull Offset position, int scrollModifier, int scrollAmount) {
        super(position);
        this.scrollModifier = scrollModifier;
        this.scrollAmount = scrollAmount;
    }

    public int getScrollModifier() {
        return scrollModifier;
    }

    public int getScrollAmount() {
        return scrollAmount;
    }
}
