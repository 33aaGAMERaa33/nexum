package io.nexum.render.instructions;

import io.nexum.models.Offset;
import io.nexum.render.RenderContext;
import io.nexum.render.RenderInstruction;
import org.jetbrains.annotations.NotNull;

import java.awt.*;

public class TranslateInstruction extends RenderInstruction {
    private final @NotNull Offset offset;

    public TranslateInstruction(@NotNull Offset offset) {
        this.offset = offset;
    }

    @Override
    public void execute(@NotNull RenderContext renderContext) {
        renderContext.translate(offset);
    }
}
