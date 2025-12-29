package io.nexum.channel.serializers.helpers;

import io.nexum.material.TestObject;
import io.nexum.channel.FriendlyBuffer;
import io.nexum.channel.HelperSerializer;
import org.jetbrains.annotations.NotNull;

public class TestObjectSerializer implements HelperSerializer<TestObject> {
    @Override
    public void serialize(@NotNull TestObject object, @NotNull FriendlyBuffer friendlyBuffer) {
        friendlyBuffer.writeString(object.getMessage());
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
