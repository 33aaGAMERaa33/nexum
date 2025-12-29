package io.nexum.channel;

import org.jetbrains.annotations.NotNull;

public interface HelperSerializer<T> {
    void serialize(@NotNull T object, @NotNull FriendlyBuffer friendlyBuffer);
    @NotNull String getIdentifier();
    @NotNull Class<T> getObjectClazz();
}
