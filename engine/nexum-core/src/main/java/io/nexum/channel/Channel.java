package io.nexum.channel;

import io.nexum.exceptions.AlreadyInitialized;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.Objects;
import java.util.concurrent.*;

import static io.nexum.Nexum.LOGGER;

public class Channel {
    private static @Nullable Channel instance = null;

    private @Nullable Future<?> senderTask;
    private final PacketManager packetManager;
    private final DataInputStream inputStream;
    private final DataInputStream errorStream;
    private final DataOutputStream outputStream;
    private final FrameworkProcessStorage frameworkProcessStorage;
    private final BlockingQueue<String> sendQueue = new LinkedBlockingQueue<>();
    private final ExecutorService sendQueueExecutor = Executors.newFixedThreadPool(1);
    private final ExecutorService incomingDataExecutors = Executors.newFixedThreadPool(2);

    private boolean isRunning = false;

    private Channel(
            FrameworkProcessStorage frameworkProcessStorage,
            PacketManager packetManager
    ) {
        this.frameworkProcessStorage = frameworkProcessStorage;
        this.packetManager = packetManager;
        final Process frameworkProcess = frameworkProcessStorage.getFrameworkProcess();

        this.inputStream = new DataInputStream(frameworkProcess.getInputStream());
        this.errorStream = new DataInputStream(frameworkProcess.getErrorStream());
        this.outputStream = new DataOutputStream(frameworkProcess.getOutputStream());

        Runtime.getRuntime().addShutdownHook(new Thread(this::stop));
    }

    public void listen() {
        if(this.isRunning) return;
        this.isRunning = true;

        handlePendingQueuePackets();

        this.incomingDataExecutors.submit(() -> {
            try {
                while (this.isRunning) {
                    final int size = this.inputStream.readInt();
                    final byte[] payload = this.inputStream.readNBytes(size);
                    final String data = new String(payload, StandardCharsets.UTF_8);

                    this.packetManager.handleReceivedData(data);
                }
            }catch (IOException e) {
                this.log("STDOUT fechado");
            }

            this.stop();
        });

        // STDERR (logs / erros do Dart)
        this.incomingDataExecutors.submit(() -> {
            try (
                    BufferedReader reader = new BufferedReader(
                            new InputStreamReader(this.errorStream, StandardCharsets.UTF_8)
                    )
            ) {
                String line;
                while (this.isRunning && (line = reader.readLine()) != null) {
                    this.error("[DART] %s", line);
                }
            } catch (Exception e) {
                this.error("Erro STDERR: %s", e.getMessage());
            }
        });
    }

    public void stop() {
        if(!this.isRunning) return;
        this.isRunning = false;

        if(this.senderTask != null) {
            this.senderTask.cancel(true);
        }

        if(frameworkProcessStorage.getFrameworkProcess().isAlive()) {
            frameworkProcessStorage.getFrameworkProcess().destroy();
        }

        this.sendQueueExecutor.shutdownNow();
        this.incomingDataExecutors.shutdownNow();

        try {
            this.inputStream.close();
            this.outputStream.close();
        }catch(Exception ignored) {}
    }

    protected void handlePendingQueuePackets() {
        this.senderTask = this.sendQueueExecutor.submit(() -> {
            while(this.isRunning) {
                try {
                    final String data = this.sendQueue.take();
                    final byte[] payload = data.getBytes(StandardCharsets.UTF_8);

                    this.outputStream.writeInt(payload.length);
                    this.outputStream.write(payload);
                    this.outputStream.flush();
                }catch (InterruptedException ignored) {
                }catch (Exception e) {
                    this.error(e.toString());
                }
            }
        });
    }

    public void send(@NotNull String data) {
        this.sendQueue.offer(data);
    }

    private void log(@NotNull String log, Object ... args) {
        LOGGER.log("Channel", log, args);
    }

    private void debug(@NotNull String log, Object ... args) {
        LOGGER.debug("Channel", log, args);
    }

    private void warn(@NotNull String log, Object ... args) {
        LOGGER.warn("Channel", log, args);
    }

    private void error(@NotNull String log, Object ... args) {
        LOGGER.error("Channel", log, args);
    }

    public static @NotNull Channel getInstance() {
        return Objects.requireNonNull(instance);
    }

    public static Channel initialize(
            FrameworkProcessStorage frameworkProcessStorage,
            PacketManager packetManager
    ) {
        if(instance != null) throw new AlreadyInitialized("Channel já foi inicializado");

        final Channel channel = new Channel(frameworkProcessStorage, packetManager);
        instance = channel;

        return channel;
    }

    public static boolean isInitialized() {
        return instance != null;
    }
}