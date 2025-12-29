package io.nexum.channel.handlers;

import io.nexum.channel.HeartbeatMonitor;
import io.nexum.channel.PacketHandler;
import io.nexum.channel.PacketManager;
import io.nexum.channel.packets.HeartBeatPacket;
import org.jetbrains.annotations.NotNull;

import java.util.Timer;
import java.util.TimerTask;

public class HeartBeatPacketHandler implements PacketHandler<HeartBeatPacket> {
    private static final int PING_TIME = 1_000;
    private static final Timer timer = new Timer();

    @Override
    public void handle(@NotNull HeartBeatPacket packet) {
        HeartbeatMonitor.onHeartbeat();

        timer.schedule(
                new TimerTask() {
                    @Override
                    public void run() {
                        PacketManager.getInstance().sendPacket(new HeartBeatPacket());
                    }
                }, PING_TIME
        );
    }

    @Override
    public @NotNull Class<HeartBeatPacket> getPacketClazz() {
        return HeartBeatPacket.class;
    }
}
