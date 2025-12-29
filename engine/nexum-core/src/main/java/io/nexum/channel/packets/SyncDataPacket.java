package io.nexum.channel.packets;

import io.nexum.models.Size;
import io.nexum.channel.Packet;
import org.jetbrains.annotations.NotNull;

public class SyncDataPacket extends Packet {
    private final int fpsLimit;
    private final @NotNull Size screenSize;

    public SyncDataPacket(int fpsLimit, @NotNull Size screenSize) {
        this.fpsLimit = fpsLimit;
        this.screenSize = screenSize;
    }

    public int getFpsLimit() {
        return fpsLimit;
    }

    public @NotNull Size getScreenSize() {
        return screenSize;
    }
}
