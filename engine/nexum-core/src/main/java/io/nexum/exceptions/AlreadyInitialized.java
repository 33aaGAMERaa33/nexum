package io.nexum.exceptions;

public class AlreadyInitialized extends RuntimeException {
    public AlreadyInitialized(String message) {
        super(message);
    }
}
