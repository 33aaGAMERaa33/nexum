package io.nexum.core.storages;

import io.nexum.channel.Packet;
import io.nexum.channel.PacketHandler;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import java.util.HashMap;

public class PacketHandlerRegistry {
    private static @NotNull PacketHandlerRegistry instance = new PacketHandlerRegistry();
    private final HashMap<Class<Packet>, PacketHandler<Packet>> handlers = new HashMap<>();

    private PacketHandlerRegistry() {

    }

    public <T extends Packet> void register(@NotNull PacketHandler<T> packetHandler) {
        @SuppressWarnings("unchecked")
        final Class<Packet> packetClazzCasted = (Class<Packet>) packetHandler.getPacketClazz();
        @SuppressWarnings("unchecked")
        final PacketHandler<Packet> packetSerializerCasted = (PacketHandler<Packet>) packetHandler;

        this.handlers.put(packetClazzCasted, packetSerializerCasted);
    }

    public <T extends Packet> @Nullable PacketHandler<Packet> get(@NotNull Class<T> clazz) {
        return this.handlers.get(clazz);
    }

    public static @NotNull PacketHandlerRegistry getInstance() {
        return instance;
    }
}
