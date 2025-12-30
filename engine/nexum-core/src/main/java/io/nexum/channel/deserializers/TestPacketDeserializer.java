package io.nexum.channel.deserializers;

import io.nexum.services.HelperDeserializerService;
import io.nexum.material.TestObject;
import io.nexum.channel.FriendlyBuffer;
import io.nexum.channel.PacketDeserializer;
import io.nexum.channel.packets.TestPacket;
import org.jetbrains.annotations.NotNull;

public class TestPacketDeserializer implements PacketDeserializer<TestPacket> {
    @Override
    public @NotNull TestPacket deserialize(@NotNull FriendlyBuffer friendlyBuffer) {
        final TestObject testObject = HelperDeserializerService.getInstance().deserialize(friendlyBuffer);
        return new TestPacket(testObject);
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
