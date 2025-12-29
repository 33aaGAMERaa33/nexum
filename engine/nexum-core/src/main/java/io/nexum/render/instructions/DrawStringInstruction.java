package io.nexum.render.instructions;

import io.nexum.render.GraphicsInstruction;
import org.jetbrains.annotations.NotNull;

import java.awt.*;

public class DrawStringInstruction extends GraphicsInstruction {
    private final @NotNull String value;

    public DrawStringInstruction(@NotNull String value) {
        this.value = value;
    }

    @Override
    public void execute(@NotNull Graphics2D graphics) {
        graphics.drawString(value, 0, graphics.getFontMetrics().getAscent());
    }
}
