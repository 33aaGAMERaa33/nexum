package io.nexum.channel.serializers;

import io.nexum.channel.FriendlyBuffer;
import io.nexum.channel.PacketSerializer;
import io.nexum.channel.packets.SyncDataPacket;
import org.jetbrains.annotations.NotNull;

public class SyncDataPacketSerializer implements PacketSerializer<SyncDataPacket> {
    @Override
    public void serialize(@NotNull SyncDataPacket packet, @NotNull FriendlyBuffer friendlyBuffer) {
        friendlyBuffer.writeInt(packet.getFpsLimit());
        friendlyBuffer.writeInt(packet.getScreenSize().getHeight());
        friendlyBuffer.writeInt(packet.getScreenSize().getWidth());
    }

    @Override
    public @NotNull String getIdentifier() {
        return "sync_data";
    }

    @Override
    public @NotNull Class<SyncDataPacket> getPacketClazz() {
        return SyncDataPacket.class;
    }
}
