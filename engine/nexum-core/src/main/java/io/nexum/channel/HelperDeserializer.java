package io.nexum.channel;

import org.jetbrains.annotations.NotNull;

public interface HelperDeserializer<T> {
    @NotNull T deserialize(@NotNull FriendlyBuffer friendlyBuffer);
    @NotNull String getIdentifier();
    @NotNull Class<T> getObjectClazz();
}
