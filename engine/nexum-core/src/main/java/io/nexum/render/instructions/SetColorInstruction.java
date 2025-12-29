package io.nexum.render.instructions;

import io.nexum.render.GraphicsInstruction;
import org.jetbrains.annotations.NotNull;

import java.awt.*;

public class SetColorInstruction extends GraphicsInstruction {
    private final @NotNull Color color;

    public SetColorInstruction(@NotNull Color color) {
        this.color = color;
    }

    @Override
    public void execute(@NotNull Graphics2D graphics) {
        graphics.setColor(color);
    }
}
