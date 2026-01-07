package io.nexum.channel.handlers;

import io.nexum.Nexum;
import io.nexum.RunInfo;
import io.nexum.channel.PacketHandler;
import io.nexum.channel.PacketManager;
import io.nexum.channel.packets.RequestDataSyncPacket;
import io.nexum.channel.packets.SyncDataPacket;
import org.jetbrains.annotations.NotNull;

public class RequestDataSyncPacketHandler implements PacketHandler<RequestDataSyncPacket> {
    @Override
    public void handle(@NotNull RequestDataSyncPacket packet) {
        final Nexum nexumInstance = Nexum.getInstance();

        final SyncDataPacket responsePacket = new SyncDataPacket(
                nexumInstance.getFpsLimit(),
                RunInfo.IS_RELEASE,
                nexumInstance.getScreenSize()
        );

        PacketManager.getInstance().sendResponsePacket(
                packet, responsePacket
        );
    }

    @Override
    public @NotNull Class<RequestDataSyncPacket> getPacketClazz() {
        return RequestDataSyncPacket.class;
    }
}
