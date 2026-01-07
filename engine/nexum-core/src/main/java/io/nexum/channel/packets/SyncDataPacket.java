package io.nexum.channel.packets;

import io.nexum.models.Size;
import io.nexum.channel.Packet;
import org.jetbrains.annotations.NotNull;

public class SyncDataPacket extends Packet {
    private final int fpsLimit;
    private final boolean release;
    private final @NotNull Size screenSize;

    public SyncDataPacket(
            int fpsLimit,
            boolean release,
            @NotNull Size screenSize
    ) {
        this.release = release;
        this.fpsLimit = fpsLimit;
        this.screenSize = screenSize;
    }

    public boolean isRelease() {
        return release;
    }

    public int getFpsLimit() {
        return fpsLimit;
    }

    public @NotNull Size getScreenSize() {
        return screenSize;
    }
}
