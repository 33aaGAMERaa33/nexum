package io.nexum.render.instructions;

import io.nexum.models.Offset;
import io.nexum.render.GraphicsInstruction;
import org.jetbrains.annotations.NotNull;

import java.awt.*;

public class TranslateInstruction extends GraphicsInstruction {
    private final @NotNull Offset offset;

    public TranslateInstruction(@NotNull Offset offset) {
        this.offset = offset;
    }

    @Override
    public void execute(@NotNull Graphics2D graphics) {
        graphics.translate(offset.getLeftPos(), offset.getTopPos());
    }
}
