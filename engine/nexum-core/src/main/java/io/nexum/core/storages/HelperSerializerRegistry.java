package io.nexum.core.storages;

import io.nexum.channel.HelperSerializer;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import java.util.HashMap;

public class HelperSerializerRegistry {
    private static @NotNull HelperSerializerRegistry instance = new HelperSerializerRegistry();
    private final HashMap<Class<Object>, HelperSerializer<Object>> serializers = new HashMap<>();

    private HelperSerializerRegistry() {

    }

    public <T> void register(@NotNull HelperSerializer<T> helperSerializer) {
        @SuppressWarnings("unchecked")
        final Class<Object> objectClassCasted = (Class<Object>) helperSerializer.getObjectClazz();
        @SuppressWarnings("unchecked")
        final HelperSerializer<Object> helperSerializerCasted = (HelperSerializer<Object>) helperSerializer;

        assert !this.serializers.containsKey(helperSerializer.getObjectClazz());
        this.serializers.put(objectClassCasted, helperSerializerCasted);
    }

    public <T> @Nullable HelperSerializer<Object> get(@NotNull Class<T> objectClazz) {
        return this.serializers.get(objectClazz);
    }

    public static @NotNull HelperSerializerRegistry getInstance() {
        return instance;
    }
}
