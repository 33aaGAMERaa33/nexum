package io.nexum.render.instructions;

import io.nexum.models.Size;
import io.nexum.render.RenderContext;
import io.nexum.render.RenderInstruction;
import org.jetbrains.annotations.NotNull;

import java.awt.*;

public class DrawRectInstruction extends RenderInstruction {
    private final @NotNull Size size;

    public DrawRectInstruction(@NotNull Size size) {
        this.size = size;
    }

    @Override
    public void execute(@NotNull RenderContext renderContext) {
        renderContext.drawRect(size);
    }

    public @NotNull Size getSize() {
        return size;
    }
}
