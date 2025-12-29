import 'package:nexum_core/channel/heart_beat_monitor.dart';
import 'package:nexum_core/channel/packet_manager.dart';
import 'package:nexum_core/channel/packets/heart_beat_packet.dart';
import 'package:nexum_core/channel/packet_handler.dart';

class HeartBeatPacketHandler extends PacketHandler<HeartBeatPacket> {
  static const _pingTime = 1_000;

  @override
  void handle(HeartBeatPacket packet) {
    HeartbeatMonitor.onHeartbeat();

    Future.delayed(
      const Duration(milliseconds: _pingTime),
      () => PacketManager.instance.sendPacket(HeartBeatPacket()),
    );
  }

  @override
  Type get packetType => HeartBeatPacket;
}