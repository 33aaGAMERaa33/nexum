package io.nexum.render;

import org.jetbrains.annotations.NotNull;

import java.awt.*;
import java.util.ArrayList;
import java.util.List;

public class GraphicsInstructionsConsumer {
    private final @NotNull List<@NotNull GraphicsInstruction> instructions = new ArrayList<>();

    public void consume(@NotNull Graphics2D graphics) {
        for(final GraphicsInstruction instruction : this.instructions) {
            instruction.execute(graphics);
        }
    }

    public void addInstruction(@NotNull GraphicsInstruction instruction) {
        this.instructions.add(instruction);
    }
}
