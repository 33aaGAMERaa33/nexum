package io.nexum.core.services;

import io.nexum.core.storages.HelperSerializerRegistry;
import io.nexum.exceptions.HelperSerializationException;
import io.nexum.channel.FriendlyBuffer;
import io.nexum.channel.HelperSerializer;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

public class HelperSerializerService {
    private static @NotNull HelperSerializerService instance = new HelperSerializerService();

    private HelperSerializerService() {

    }

    public <T> void serialize(@NotNull T object, @NotNull FriendlyBuffer friendlyBuffer) {
        @Nullable
        final HelperSerializer<Object> helperSerializer = HelperSerializerRegistry.getInstance().get(object.getClass());

        if(helperSerializer == null) throw new HelperSerializationException(
                String.format("O serializador para o objeto %s não foi encontrado", object.getClass().getSimpleName())
        );

        helperSerializer.serialize(object, friendlyBuffer);
        friendlyBuffer.write("identifier", helperSerializer.getIdentifier());
    }

    public static @NotNull HelperSerializerService getInstance() {
        return instance;
    }
}
