package io.nexum.render.instructions;

import io.nexum.models.Offset;
import io.nexum.models.Size;
import io.nexum.render.GraphicsInstruction;
import org.jetbrains.annotations.NotNull;

import java.awt.*;

public class DrawRectInstruction extends GraphicsInstruction {
    private final @NotNull Offset offset;
    private final @NotNull Size size;

    public DrawRectInstruction(@NotNull Offset offset, @NotNull Size size) {
        this.offset = offset;
        this.size = size;
    }

    @Override
    public void execute(@NotNull Graphics2D graphics) {
        graphics.drawRect(
                offset.getLeftPos(), offset.getTopPos(),
                size.getWidth(), size.getHeight()
        );
    }

    public @NotNull Offset getOffset() {
        return offset;
    }

    public @NotNull Size getSize() {
        return size;
    }
}
