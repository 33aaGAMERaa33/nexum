package io.nexum.channel.deserializers;

import io.nexum.channel.FriendlyBuffer;
import io.nexum.channel.PacketDeserializer;
import io.nexum.channel.packets.HeartBeatPacket;
import org.jetbrains.annotations.NotNull;

public class HeartBeatPacketDeserializer implements PacketDeserializer<HeartBeatPacket> {
    @Override
    public @NotNull HeartBeatPacket deserialize(@NotNull FriendlyBuffer friendlyBuffer) {
        return new HeartBeatPacket();
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
