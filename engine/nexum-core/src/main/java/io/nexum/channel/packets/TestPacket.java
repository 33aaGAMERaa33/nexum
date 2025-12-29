package io.nexum.channel.packets;

import io.nexum.material.TestObject;
import io.nexum.channel.Packet;
import org.jetbrains.annotations.NotNull;

public class TestPacket extends Packet {
    private final @NotNull TestObject test;

    public TestPacket(@NotNull TestObject test) {
        this.test = test;
    }

    public @NotNull TestObject getObject() {
        return this.test;
    }
}
