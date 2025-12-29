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
import io.nexum.render.GraphicsInstructionsConsumer;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import java.awt.*;
import java.awt.image.BufferedImage;
import java.util.Objects;

public class Nexum {
    private final int fpsLimit;
    private boolean started = false;
    private final @NotNull Size screenSize;
    private @Nullable NexumRenderer renderer;
    private @Nullable BufferedImage lastFrame;
    private final int imageType = BufferedImage.TYPE_INT_ARGB_PRE;

    private static @Nullable Nexum instance;
    public static final Logger LOGGER = new Logger();

    protected Nexum(int fpsLimit, @NotNull Size screenSize) {
        this.fpsLimit = Math.min(300, fpsLimit);
        this.screenSize = screenSize;
    }

    public @NotNull BufferedImage render(@NotNull GraphicsInstructionsConsumer consumer) {
        final long start = System.nanoTime();

        final BufferedImage frame = new BufferedImage(
                this.screenSize.getWidth(),
                this.screenSize.getHeight(),
                this.imageType
        );

        final Graphics2D graphics = frame.createGraphics();
        consumer.consume(graphics);
        graphics.dispose();

        if(renderer != null) renderer.render(frame);

        this.lastFrame = frame;

        final long end = System.nanoTime();
        final long elapsed = (end - start) / 1_000_000;

        this.log("Tempo de renderização: %sms", elapsed);
        return frame;
    }

    public <T extends Event> void emitEvent(@NotNull T event) {
        PacketManager.getInstance().sendPacket(new EventPacket(event));
    }

    public void start() {
        if(started) throw new RuntimeException("Já foi iniciado");
        started = true;

        try {
            final FrameworkProcessStorage frameworkProcessStorage = FrameworkProcessStorage.initialize();

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

    public void setRenderer(@Nullable NexumRenderer renderer) {
        this.renderer = renderer;
        if(renderer != null && this.lastFrame != null) renderer.render(this.lastFrame);
    }

    public int getFpsLimit() {
        return this.fpsLimit;
    }

    public @NotNull Size getScreenSize() {
        return this.screenSize;
    }

    public int getImageType() {
        return this.imageType;
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
