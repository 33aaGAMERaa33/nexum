package io.nexum.render.instructions;

import io.nexum.render.RenderContext;
import io.nexum.render.RenderInstruction;
import org.jetbrains.annotations.NotNull;

import java.awt.*;

public class SetCompositeInstruction extends RenderInstruction {
    private final float alpha;

    public SetCompositeInstruction(float alpha) {
        this.alpha = alpha;
    }

    @Override
    public void execute(@NotNull RenderContext renderContext) {
        renderContext.setComposite(this.alpha);
    }

    public float getAlpha() {
        return alpha;
    }
}
