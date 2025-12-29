package io.nexum.render.instructions;

import io.nexum.render.RenderContext;
import io.nexum.render.RenderInstruction;
import io.nexum.render.RenderContextConsumer;
import org.jetbrains.annotations.NotNull;

import java.awt.*;

public class CreateSubContextInstruction extends RenderInstruction {
    private final @NotNull RenderContextConsumer consumer;

    public CreateSubContextInstruction(@NotNull RenderContextConsumer consumer) {
        this.consumer = consumer;
    }

    @Override
    public void execute(@NotNull RenderContext renderContext) {
        final RenderContext subContext = renderContext.create();

        consumer.consume(subContext);
        subContext.endFrame();
    }
}
