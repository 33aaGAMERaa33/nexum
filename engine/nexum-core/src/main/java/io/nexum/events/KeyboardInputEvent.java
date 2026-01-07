package io.nexum.events;

public class KeyboardInputEvent extends InputEvent {
    private final int keyCode;
    private final boolean released;

    public KeyboardInputEvent(int keyCode, boolean released) {
        this.keyCode = keyCode;
        this.released = released;
    }

    public int getKeyCode() {
        return keyCode;
    }

    public boolean isReleased() {
        return released;
    }
}
