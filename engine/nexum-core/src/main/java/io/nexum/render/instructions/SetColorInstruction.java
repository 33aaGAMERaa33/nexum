package io.nexum.render.instructions;

import io.nexum.render.RenderContext;
import io.nexum.render.RenderInstruction;
import org.jetbrains.annotations.NotNull;

import java.awt.*;

public class SetColorInstruction extends RenderInstruction {
    private final @NotNull Color color;

    public SetColorInstruction(@NotNull Color color) {
        this.color = color;
    }

    @Override
    public void execute(@NotNull RenderContext renderContext) {
        renderContext.setColor(color);
    }
}
