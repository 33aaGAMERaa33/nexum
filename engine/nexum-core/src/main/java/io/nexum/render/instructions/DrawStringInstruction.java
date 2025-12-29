package io.nexum.render.instructions;

import io.nexum.render.RenderContext;
import io.nexum.render.RenderInstruction;
import org.jetbrains.annotations.NotNull;

import java.awt.*;

public class DrawStringInstruction extends RenderInstruction {
    private final @NotNull String value;

    public DrawStringInstruction(@NotNull String value) {
        this.value = value;
    }

    @Override
    public void execute(@NotNull RenderContext renderContext) {
        renderContext.drawString(value);
    }
}
