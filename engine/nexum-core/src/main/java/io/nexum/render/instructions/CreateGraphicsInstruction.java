package io.nexum.render.instructions;

import io.nexum.render.GraphicsInstruction;
import io.nexum.render.GraphicsInstructionsConsumer;
import org.jetbrains.annotations.NotNull;

import java.awt.*;

public class CreateGraphicsInstruction extends GraphicsInstruction {
    private final @NotNull GraphicsInstructionsConsumer consumer;

    public CreateGraphicsInstruction(@NotNull GraphicsInstructionsConsumer consumer) {
        this.consumer = consumer;
    }

    @Override
    public void execute(@NotNull Graphics2D graphics) {
        final Graphics2D createdGraphics = (Graphics2D) graphics.create();

        consumer.consume(createdGraphics);

        createdGraphics.dispose();
    }
}
