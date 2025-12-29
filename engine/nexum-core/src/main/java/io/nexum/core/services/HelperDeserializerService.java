package io.nexum.core.services;

import io.nexum.core.storages.HelperDeserializerRegistry;
import io.nexum.exceptions.HelperDeserializationException;
import io.nexum.channel.FriendlyBuffer;
import io.nexum.channel.HelperDeserializer;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

public class HelperDeserializerService {
    private static @NotNull HelperDeserializerService instance = new HelperDeserializerService();

    private HelperDeserializerService() {

    }

    public <T> @NotNull T deserialize(@NotNull FriendlyBuffer friendlyBuffer) {
        final String identifier = friendlyBuffer.read("identifier");

        @Nullable
        final HelperDeserializer<Object> helperDeserializer = HelperDeserializerRegistry.getInstance().get(identifier);

        if(helperDeserializer == null) throw new HelperDeserializationException(
                String.format("O desserializador de identificador %s não foi encontrado", identifier)
        );

        @SuppressWarnings("unchecked")
        final T object = (T) helperDeserializer.deserialize(friendlyBuffer);
        return object;
    }

    public static @NotNull HelperDeserializerService getInstance() {
        return instance;
    }
}
