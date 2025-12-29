package io.nexum.render.instructions;

import io.nexum.render.RenderContext;
import io.nexum.render.RenderInstruction;
import org.jetbrains.annotations.NotNull;

import java.awt.*;

public class SetFontInstruction extends RenderInstruction {
    private final @NotNull Font font;

    public SetFontInstruction(@NotNull Font font) {
        this.font = font;
    }

    @Override
    public void execute(@NotNull RenderContext renderContext) {
        renderContext.setFont(font);
    }
}
