package io.nexum.material;

import java.awt.*;

public class TextStyle {
    private final Color color;
    private final int fontSize;

    public TextStyle(Color color, int fontSize) {
        this.color = color;
        this.fontSize = fontSize;
    }

    public Color getColor() {
        return color;
    }

    public int getFontSize() {
        return fontSize;
    }
}
