package io.nexum.channel.deserializers;

import io.nexum.channel.FriendlyBuffer;
import io.nexum.channel.PacketDeserializer;
import io.nexum.channel.packets.LoggerPacket;
import org.jetbrains.annotations.NotNull;

public class LoggerPacketDeserializer implements PacketDeserializer<LoggerPacket> {
    @Override
    public @NotNull LoggerPacket deserialize(@NotNull FriendlyBuffer friendlyBuffer) {
        final String logType = friendlyBuffer.readString();
        final String identifier = friendlyBuffer.readString();
        final String log = friendlyBuffer.readString();

        return new LoggerPacket(identifier, log, Enum.valueOf(LoggerPacket.LoggerType.class, logType.toUpperCase()));
    }

    @Override
    public @NotNull String getIdentifier() {
        return "logger";
    }

    @Override
    public @NotNull Class<LoggerPacket> getPacketClazz() {
        return LoggerPacket.class;
    }
}
