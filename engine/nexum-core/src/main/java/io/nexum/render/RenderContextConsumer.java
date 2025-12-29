package io.nexum.render;

import org.jetbrains.annotations.NotNull;

import java.awt.*;
import java.util.ArrayList;
import java.util.List;

public class RenderContextConsumer {
    private final @NotNull List<@NotNull RenderInstruction> instructions = new ArrayList<>();

    public void consume(@NotNull RenderContext renderContext) {
        for(final RenderInstruction instruction : this.instructions) {
            instruction.execute(renderContext);
        }
    }

    public void addInstruction(@NotNull RenderInstruction instruction) {
        this.instructions.add(instruction);
    }
}
