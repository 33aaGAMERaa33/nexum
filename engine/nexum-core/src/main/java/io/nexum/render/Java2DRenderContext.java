package io.nexum.render;

import io.nexum.models.Offset;
import io.nexum.models.Size;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import java.awt.*;
import java.awt.image.BufferedImage;

public class Java2DRenderContext implements RenderContext {
    private final @NotNull BufferedImage frame;
    private @Nullable Graphics2D graphics;

    public Java2DRenderContext(@NotNull BufferedImage frame) {
        this.frame = frame;
    }

    private Java2DRenderContext(@NotNull BufferedImage frame, @NotNull Graphics2D graphics) {
        this.frame = frame;
        this.graphics = graphics;
    }

    @Override
    public void beginFrame() {
        assert this.graphics == null;
        this.graphics = frame.createGraphics();

        this.graphics.setComposite(AlphaComposite.Clear);
        this.graphics.fillRect(0, 0, this.frame.getWidth(), this.frame.getHeight());
        this.graphics.setComposite(AlphaComposite.Src);
    }

    @Override
    public void endFrame() {
        assert this.graphics != null;
        this.getGraphics().dispose();
        this.graphics = null;
    }

    @Override
    public @NotNull RenderContext create() {
        return new Java2DRenderContext(this.frame, (Graphics2D) this.getGraphics().create());
    }

    @Override
    public @NotNull RenderContext createWithoutContext() {
        return new Java2DRenderContext(this.frame, this.frame.createGraphics());
    }

    @Override
    public @NotNull RenderContext create(@NotNull Offset offset, @NotNull Size size) {
        final RenderContext subContext = this.create();
        subContext.clipRect(offset, size);

        return subContext;
    }

    @Override
    public void drawString(@NotNull String value) {
        this.getGraphics().drawString(value, 0, this.getGraphics().getFontMetrics().getAscent());
    }

    @Override
    public void setColor(@NotNull Color color) {
        this.getGraphics().setColor(color);
    }

    @Override
    public void setFont(@NotNull Font font) {
        this.getGraphics().setFont(font);
    }

    @Override
    public void setComposite(float alpha) {
        this.getGraphics().setComposite(AlphaComposite.getInstance(
                AlphaComposite.SRC_OVER,
                alpha
        ));
    }

    @Override
    public void translate(@NotNull Offset offset) {
        this.getGraphics().translate(offset.getLeftPos(), offset.getTopPos());
    }

    @Override
    public void drawRect(@NotNull Size rectSize) {
        this.getGraphics().drawRect(
                0, 0,
                rectSize.getWidth(), rectSize.getHeight()
        );
    }

    @Override
    public void clipRect(@NotNull Offset offset, @NotNull Size size) {
        this.getGraphics().clipRect(
                offset.getLeftPos(), offset.getTopPos(),
                size.getWidth(), size.getHeight()
        );
    }

    public @NotNull Graphics2D getGraphics() {
        assert this.graphics != null;
        return this.graphics;
    }
}
