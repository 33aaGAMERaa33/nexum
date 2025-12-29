package io.nexum.channel.packets;

import io.nexum.channel.Packet;
import org.jetbrains.annotations.NotNull;

public class LoggerPacket extends Packet {
    private final @NotNull String log;
    private final @NotNull LoggerType type;
    private final @NotNull String identifier;

    public LoggerPacket(@NotNull String identifier, @NotNull String log, @NotNull LoggerType type) {
        this.log = log;
        this.type = type;
        this.identifier = identifier;
    }

    public @NotNull String getIdentifier() {
        return identifier;
    }

    public @NotNull String getLog() {
        return log;
    }

    public @NotNull LoggerType getType() {
        return type;
    }

    public enum LoggerType {
        LOG("log"),
        WARN("warn"),
        ERROR("error"),
        DEBUG("debug");

        final String identifier;

        LoggerType(String identifier) {
            this.identifier = identifier;
        }

        public String getIdentifier() {
            return identifier;
        }
    }
}
