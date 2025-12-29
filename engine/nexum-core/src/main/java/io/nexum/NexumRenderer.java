package io.nexum;

import org.jetbrains.annotations.NotNull;

import java.awt.image.BufferedImage;

public interface NexumRenderer {
    void render(@NotNull BufferedImage frame);
}
