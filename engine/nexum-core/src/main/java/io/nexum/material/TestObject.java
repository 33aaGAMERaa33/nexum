package io.nexum.material;

import org.jetbrains.annotations.NotNull;

public class TestObject {
    private final @NotNull String message;

    public TestObject(@NotNull String message) {
        this.message = message;
    }

    public @NotNull String getMessage() {
        return message;
    }
}
