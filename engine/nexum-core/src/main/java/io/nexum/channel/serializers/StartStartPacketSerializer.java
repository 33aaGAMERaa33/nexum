package io.nexum.channel.serializers;

import io.nexum.channel.FriendlyBuffer;
import io.nexum.channel.PacketSerializer;
import io.nexum.channel.packets.StartPacket;
import org.jetbrains.annotations.NotNull;

public class StartStartPacketSerializer implements PacketSerializer<StartPacket> {
    @Override
    public void serialize(@NotNull StartPacket packet, @NotNull FriendlyBuffer friendlyBuffer) {

    }

    @Override
    public @NotNull String getIdentifier() {
        return "start";
    }

    @Override
    public @NotNull Class<StartPacket> getPacketClazz() {
        return StartPacket.class;
    }
}
