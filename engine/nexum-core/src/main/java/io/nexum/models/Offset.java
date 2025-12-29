package io.nexum.models;

public class Offset {
    private final int leftPos;
    private final int topPos;

    public Offset(int leftPos, int topPos) {
        this.leftPos = leftPos;
        this.topPos = topPos;
    }

    public int getLeftPos() {
        return leftPos;
    }

    public int getTopPos() {
        return topPos;
    }
}
