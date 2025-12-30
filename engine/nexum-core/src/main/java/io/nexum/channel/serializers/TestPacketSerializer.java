package io.nexum.channel.serializers;

import io.nexum.services.HelperSerializerService;
import io.nexum.channel.FriendlyBuffer;
import io.nexum.channel.PacketSerializer;
import io.nexum.channel.packets.TestPacket;
import org.jetbrains.annotations.NotNull;

public class TestPacketSerializer implements PacketSerializer<TestPacket> {
    @Override
    public void serialize(@NotNull TestPacket packet, @NotNull FriendlyBuffer friendlyBuffer) {
        HelperSerializerService.getInstance().serialize(packet.getObject(), friendlyBuffer);
    }

    @Override
    public @NotNull String getIdentifier() {
        return "test";
    }

    @Override
    public @NotNull Class<TestPacket> getPacketClazz() {
        return TestPacket.class;
    }
}
