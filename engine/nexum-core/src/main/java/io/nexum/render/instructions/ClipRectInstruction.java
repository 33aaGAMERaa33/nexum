package io.nexum.render.instructions;

import io.nexum.models.Offset;
import io.nexum.models.Size;
import io.nexum.render.RenderContext;
import io.nexum.render.RenderInstruction;
import org.jetbrains.annotations.NotNull;

import java.awt.*;

public class ClipRectInstruction extends RenderInstruction {
    private final @NotNull Offset offset;
    private final @NotNull Size size;

    public ClipRectInstruction(@NotNull Offset offset, @NotNull Size size) {
        this.offset = offset;
        this.size = size;
    }

    @Override
    public void execute(@NotNull RenderContext renderContext) {
        renderContext.clipRect(offset, size);
    }
}
