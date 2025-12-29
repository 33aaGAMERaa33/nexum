package io.nexum.render;

import org.jetbrains.annotations.NotNull;

import java.awt.*;

public abstract class GraphicsInstruction {
    public abstract void execute(@NotNull Graphics2D graphics);
}
