package io.nexum.core.storages;
import io.nexum.exceptions.HelperDeserializationException;
import io.nexum.channel.HelperDeserializer;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import java.util.HashMap;

public class HelperDeserializerRegistry {
    private final HashMap<String, HelperDeserializer<Object>> deserializers = new HashMap<>();
    private static final HelperDeserializerRegistry instance = new HelperDeserializerRegistry();

    private HelperDeserializerRegistry() {

    }

    public <T> void register(@NotNull HelperDeserializer<T> packetDeserializer) {
        @SuppressWarnings("unchecked")
        final HelperDeserializer<Object> casted = (HelperDeserializer<Object>) packetDeserializer;

        assert !this.deserializers.containsKey(packetDeserializer.getIdentifier()) : new HelperDeserializationException(
                String.format("O identificador %s já foi registrado", packetDeserializer.getIdentifier())
        );

        this.deserializers.put(packetDeserializer.getIdentifier(), casted);
    }

    public @Nullable HelperDeserializer<Object> get(@NotNull String identifier) {
        return this.deserializers.get(identifier);
    }

    public static HelperDeserializerRegistry getInstance() {
        return instance;
    }
}
