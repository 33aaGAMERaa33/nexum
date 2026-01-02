package io.nexum.channel.deserializers.helpers;

import io.nexum.channel.FriendlyBuffer;
import io.nexum.channel.HelperDeserializer;
import io.nexum.render.RenderInstruction;
import org.jetbrains.annotations.NotNull;

import java.util.UUID;

public class RenderInstructionDeserializer implements HelperDeserializer<RenderInstruction> {
    @Override
    public @NotNull RenderInstruction deserialize(@NotNull FriendlyBuffer friendlyBuffer) {
        final UUID uuid = UUID.fromString(friendlyBuffer.readString());
        final RenderInstruction instruction = RenderInstruction.fromUUID(uuid);
        assert instruction != null;

        return instruction;
    }

    @Override
    public @NotNull String getIdentifier() {
        return "render_instruction";
    }

    @Override
    public @NotNull Class<RenderInstruction> getObjectClazz() {
        return RenderInstruction.class;
    }
}
