package io.nexum.channel.handlers;

import io.nexum.helpers.Logger;
import io.nexum.channel.PacketHandler;
import io.nexum.channel.packets.LoggerPacket;
import org.jetbrains.annotations.NotNull;

import java.lang.reflect.Method;

import static io.nexum.Nexum.LOGGER;

public class LoggerPacketHandler implements PacketHandler<LoggerPacket> {
    @Override
    public void handle(@NotNull LoggerPacket packet) {
        try {
            final Method method = LOGGER.getClass().getDeclaredMethod(
                    packet.getType().getIdentifier(),
                    String.class, Logger.LoggerSide.class, String.class, Object[].class
            );

            method.invoke(LOGGER, packet.getIdentifier(), Logger.LoggerSide.FRAMEWORK, packet.getLog(), new Object[0]);
        }catch(Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public @NotNull Class<LoggerPacket> getPacketClazz() {
        return LoggerPacket.class;
    }
}
