package io.nexum.render.instructions;

import io.nexum.models.Offset;
import io.nexum.models.Size;
import io.nexum.render.GraphicsInstruction;
import org.jetbrains.annotations.NotNull;

import java.awt.*;

public class ClipRectInstruction extends GraphicsInstruction {
    private final @NotNull Offset offset;
    private final @NotNull Size size;

    public ClipRectInstruction(@NotNull Offset offset, @NotNull Size size) {
        this.offset = offset;
        this.size = size;
    }

    @Override
    public void execute(@NotNull Graphics2D graphics) {
        graphics.clipRect(
                offset.getLeftPos(), offset.getTopPos(),
                size.getWidth(), size.getHeight()
        );
    }
}
