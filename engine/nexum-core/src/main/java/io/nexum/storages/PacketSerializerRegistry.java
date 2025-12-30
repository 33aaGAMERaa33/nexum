package io.nexum.storages;

import io.nexum.channel.Packet;
import io.nexum.channel.PacketSerializer;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import java.util.HashMap;

public class PacketSerializerRegistry {
    private static @NotNull PacketSerializerRegistry instance = new PacketSerializerRegistry();
    private final HashMap<Class<Packet>, PacketSerializer<Packet>> serializers = new HashMap<>();

    private PacketSerializerRegistry() {

    }

    public <T extends Packet> void register(@NotNull PacketSerializer<T> packetSerializer) {
        @SuppressWarnings("unchecked")
        final Class<Packet> packetClazzCasted = (Class<Packet>) packetSerializer.getPacketClazz();
        @SuppressWarnings("unchecked")
        final PacketSerializer<Packet> packetSerializerCasted = (PacketSerializer<Packet>) packetSerializer;

        assert !this.serializers.containsKey(packetClazzCasted);
        this.serializers.put(packetClazzCasted, packetSerializerCasted);
    }

    public <T extends Packet> @Nullable PacketSerializer<Packet> get(@NotNull Class<T> clazz) {
        return this.serializers.get(clazz);
    }

    public static @NotNull PacketSerializerRegistry getInstance() {
        return instance;
    }
}
