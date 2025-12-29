package io.nexum.render.instructions;

import io.nexum.render.GraphicsInstruction;
import org.jetbrains.annotations.NotNull;

import java.awt.*;

public class SetCompositeInstruction extends GraphicsInstruction {
    private final float alpha;

    public SetCompositeInstruction(float alpha) {
        this.alpha = alpha;
    }

    @Override
    public void execute(@NotNull Graphics2D graphics) {
        graphics.setComposite(AlphaComposite.getInstance(
                AlphaComposite.SRC_OVER,
                this.alpha
        ));
    }

    public float getAlpha() {
        return alpha;
    }
}
