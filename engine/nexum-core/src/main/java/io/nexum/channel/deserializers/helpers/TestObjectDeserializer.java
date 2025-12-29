package io.nexum.channel.deserializers.helpers;

import io.nexum.material.TestObject;
import io.nexum.channel.FriendlyBuffer;
import io.nexum.channel.HelperDeserializer;
import org.jetbrains.annotations.NotNull;

public class TestObjectDeserializer implements HelperDeserializer<TestObject> {
    @Override
    public @NotNull TestObject deserialize(@NotNull FriendlyBuffer friendlyBuffer) {
        return new TestObject(friendlyBuffer.readString());
    }

    @Override
    public @NotNull String getIdentifier() {
        return "test_object";
    }

    @Override
    public @NotNull Class<TestObject> getObjectClazz() {
        return TestObject.class;
    }
}
