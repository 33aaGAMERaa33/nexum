package io.nexum.render.instructions;

import io.nexum.render.GraphicsInstruction;
import org.jetbrains.annotations.NotNull;

import java.awt.*;

public class SetFontInstruction extends GraphicsInstruction {
    private final @NotNull Font font;

    public SetFontInstruction(@NotNull Font font) {
        this.font = font;
    }

    @Override
    public void execute(@NotNull Graphics2D graphics) {
        graphics.setFont(font);
    }
}
