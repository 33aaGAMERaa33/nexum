package io.nexum.services;

import io.nexum.storages.PacketHandlerRegistry;
import io.nexum.exceptions.PacketHandleException;
import io.nexum.channel.Packet;
import io.nexum.channel.PacketHandler;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

public class PacketHandlerService {
    private static @NotNull PacketHandlerService instance = new PacketHandlerService();

    private PacketHandlerService() {

    }

    public <T extends Packet> void handlePacket(@NotNull T packet) {
        @Nullable
        final PacketHandler<Packet> packetHandler = PacketHandlerRegistry.getInstance().get(packet.getClass());

        if(packetHandler == null) throw new PacketHandleException(
                String.format("O pacote %s não possui um handler", packet.getClass().getSimpleName())
        );

        packetHandler.handle(packet);
    }

    public static @NotNull PacketHandlerService getInstance() {
        return instance;
    }
}
