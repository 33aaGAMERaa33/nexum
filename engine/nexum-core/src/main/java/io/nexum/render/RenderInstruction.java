package io.nexum.render;

import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import java.util.*;

public abstract class RenderInstruction {
    private @Nullable UUID uuid;
    private static final Map<UUID, RenderInstruction> instructionsCache = new HashMap<>();

    public abstract void execute(@NotNull RenderContext renderContext);

    public void attach(@NotNull UUID uuid) {
        assert this.uuid == null;
        assert !instructionsCache.containsKey(uuid);

        this.uuid = uuid;
        instructionsCache.put(uuid, this);
    }

    public @NotNull UUID getUUID() {
        assert this.uuid != null;
        return this.uuid;
    }

    public static @Nullable RenderInstruction fromUUID(@NotNull UUID uuid) {
        return instructionsCache.get(uuid);
    }
}
