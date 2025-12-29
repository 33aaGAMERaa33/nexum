package io.nexum.channel.deserializers;

import io.nexum.channel.FriendlyBuffer;
import io.nexum.channel.PacketDeserializer;
import io.nexum.channel.packets.RequestDataSyncPacket;
import org.jetbrains.annotations.NotNull;

public class RequestDataSyncPacketDeserializer implements PacketDeserializer<RequestDataSyncPacket> {
    @Override
    public @NotNull RequestDataSyncPacket deserialize(@NotNull FriendlyBuffer friendlyBuffer) {
        return new RequestDataSyncPacket();
    }

    @Override
    public @NotNull String getIdentifier() {
        return "request_data_sync";
    }

    @Override
    public @NotNull Class<RequestDataSyncPacket> getPacketClazz() {
        return RequestDataSyncPacket.class;
    }
}
