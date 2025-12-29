package io.nexum.channel.serializers;

import io.nexum.channel.FriendlyBuffer;
import io.nexum.channel.PacketSerializer;
import io.nexum.channel.packets.HeartBeatPacket;
import org.jetbrains.annotations.NotNull;

public class HeartBeatPacketSerializer implements PacketSerializer<HeartBeatPacket> {
    @Override
    public void serialize(@NotNull HeartBeatPacket packet, @NotNull FriendlyBuffer friendlyBuffer) {

    }

    @Override
    public @NotNull String getIdentifier() {
        return "heart_beat";
    }

    @Override
    public @NotNull Class<HeartBeatPacket> getPacketClazz() {
        return HeartBeatPacket.class;
    }
}
