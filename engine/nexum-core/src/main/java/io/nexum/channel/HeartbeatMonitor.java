package io.nexum.channel;

import io.nexum.channel.packets.HeartBeatPacket;

import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

public class HeartbeatMonitor {
    private static final long TIMEOUT = 10_000;
    private static volatile long lastSeen = System.currentTimeMillis();
    private static final ScheduledExecutorService scheduler = Executors.newSingleThreadScheduledExecutor();

    public static void start() {
        scheduler.scheduleAtFixedRate(() -> {
            if(System.currentTimeMillis() - lastSeen > TIMEOUT) {
                shutdown();
            }
        }, 1, 1, TimeUnit.SECONDS);

        PacketManager.getInstance().sendPacket(new HeartBeatPacket());
    }

    public static void onHeartbeat() {
        lastSeen = System.currentTimeMillis();
    }

    private static void shutdown() {
        scheduler.shutdownNow();
        System.exit(0);
    }
}
