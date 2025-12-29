package io.nexum.channel.packets;

import io.nexum.events.Event;
import io.nexum.channel.Packet;
import org.jetbrains.annotations.NotNull;

public class EventPacket extends Packet {
    private final @NotNull Event event;

    public EventPacket(@NotNull Event event) {
        this.event = event;
    }

    public @NotNull Event getEvent() {
        return event;
    }
}
