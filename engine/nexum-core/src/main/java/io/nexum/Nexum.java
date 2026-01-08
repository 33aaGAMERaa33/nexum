package io.nexum;

import io.nexum.channel.Channel;
import io.nexum.channel.FrameworkProcessStorage;
import io.nexum.channel.HeartbeatMonitor;
import io.nexum.events.Event;
import io.nexum.exceptions.AlreadyInitialized;
import io.nexum.helpers.Logger;
import io.nexum.models.Size;
import io.nexum.channel.PacketManager;
import io.nexum.channel.packets.EventPacket;
import io.nexum.render.RenderContext;
import io.nexum.render.RenderContextConsumer;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import java.awt.*;
import java.util.Objects;

public class Nexum {
    private final int fpsLimit;
    private boolean started = false;
    private @Nullable Runnable onRender;
    private final @NotNull Size screenSize;
    private @Nullable RenderContext renderContext;
    private @NotNull String frameworkPath = "../../";

    private static @Nullable Nexum instance;
    public static final Logger LOGGER = new Logger();

    protected Nexum(int fpsLimit, @NotNull Size screenSize) {
        this.fpsLimit = Math.min(300, fpsLimit);
        this.screenSize = screenSize;
    }

    public void render(@NotNull RenderContextConsumer consumer) {
        if(this.renderContext == null) return;

        final long start = System.nanoTime();

        this.renderContext.beginFrame();
        consumer.consume(this.renderContext);
        this.renderContext.endFrame();
        if(this.onRender != null) this.onRender.run();

        final long end = System.nanoTime();
        final long elapsed = (end - start) / 1_000_000;

        this.log("Tempo de renderização: %sms", elapsed);
    }

    public <T extends Event> void emitEvent(@NotNull T event) {
        PacketManager.getInstance().sendPacket(new EventPacket(event));
    }

    public void start() {
        this.start(this.frameworkPath);
    }

    public void start(@NotNull String frameworkPath) {
        if(started) throw new RuntimeException("Já foi iniciado");
        started = true;

        try {
            final FrameworkProcessStorage frameworkProcessStorage = FrameworkProcessStorage.initialize(
                    frameworkPath
            );

            final PacketManager packetManager = PacketManager.initialize();

            final Channel channel = Channel.initialize(
                    frameworkProcessStorage,
                    packetManager
            );

            channel.listen();
            HeartbeatMonitor.start();
        }catch(Exception e) {
            e.printStackTrace();
        }
    }

    public void stop() {
        if(!started) return;
        System.exit(0);
    }

    public void setRenderContext(@Nullable RenderContext renderContext) {
        this.renderContext = renderContext;
    }

    public void setOnRender(@Nullable Runnable onRender) {
        this.onRender = onRender;
    }

    public int getFpsLimit() {
        return this.fpsLimit;
    }

    public @NotNull Size getScreenSize() {
        return this.screenSize;
    }

    public static Nexum initialize(int fpsLimit, @NotNull Size screenSize) {
        if(Nexum.instance != null) throw new AlreadyInitialized("Nexum já foi inicializado");
        final Nexum nexum = new Nexum(fpsLimit, screenSize);
        Nexum.instance = nexum;

        return nexum;
    }

    public static @NotNull Nexum getInstance() {
        return Objects.requireNonNull(instance);
    }

    public static boolean isInitialized() {
        return instance != null;
    }

    protected void log(@NotNull String log, Object ... args) {
        LOGGER.log("Nexum", log, args);
    }
}
