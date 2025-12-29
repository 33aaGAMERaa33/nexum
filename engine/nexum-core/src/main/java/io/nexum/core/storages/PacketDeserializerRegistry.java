package io.nexum.core.storages;

import io.nexum.channel.Packet;
import io.nexum.channel.PacketDeserializer;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import java.util.HashMap;

public class PacketDeserializerRegistry {
    private final HashMap<String, PacketDeserializer<Packet>> deserializers = new HashMap<>();
    private static final PacketDeserializerRegistry instance = new PacketDeserializerRegistry();

    private PacketDeserializerRegistry() {

    }

    public <T extends Packet> void register(@NotNull PacketDeserializer<T> packetDeserializer) {
        @SuppressWarnings("unchecked")
        final PacketDeserializer<Packet> casted = (PacketDeserializer<Packet>) packetDeserializer;

        assert !this.deserializers.containsKey(packetDeserializer.getIdentifier());
        this.deserializers.put(packetDeserializer.getIdentifier(), casted);
    }

    public @Nullable PacketDeserializer<Packet> get(@NotNull String identifier) {
        return this.deserializers.get(identifier);
    }

    public static PacketDeserializerRegistry getInstance() {
        return instance;
    }
}
