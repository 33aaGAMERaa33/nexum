package io.nexum.render;

import org.jetbrains.annotations.NotNull;

import java.awt.*;

public abstract class RenderInstruction {
    public abstract void execute(@NotNull RenderContext renderContext);
}
