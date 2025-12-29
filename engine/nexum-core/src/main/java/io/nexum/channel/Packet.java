package io.nexum.channel;

import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import java.util.UUID;

public class Packet {
    private @Nullable UUID uuid;

    public void setUUID(@NotNull UUID uuid) {
        assert this.uuid == null;
        this.uuid = uuid;
    }

    public @Nullable UUID getUUID() {
        return uuid;
    }
}
