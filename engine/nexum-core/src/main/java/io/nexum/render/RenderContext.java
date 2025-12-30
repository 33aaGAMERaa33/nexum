package io.nexum.render;

import io.nexum.models.Offset;
import io.nexum.models.Size;
import org.jetbrains.annotations.NotNull;

import java.awt.*;

public interface RenderContext {
    @NotNull RenderContext create();
    @NotNull RenderContext createWithoutContext();
    @NotNull RenderContext create(@NotNull Offset offset, @NotNull Size size);

    void beginFrame();
    void endFrame();

    void drawString(@NotNull String value);
    void setColor(@NotNull Color color);
    void setFont(@NotNull Font font);
    void setComposite(float alpha);
    void translate(@NotNull Offset offset);
    void drawRect(@NotNull Size rectSize);
    void clipRect(@NotNull Offset offset, @NotNull Size size);
}
