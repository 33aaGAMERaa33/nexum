import 'package:nexum_core/channel/heart_beat_monitor.dart';
import 'package:nexum_core/core/nexum.dart';
import 'package:nexum_core/material/widget.dart';
import 'package:nexum_core/channel/channel.dart';
import 'package:nexum_core/channel/packet_manager.dart';
import 'package:nexum_core/channel/packets/request_data_sync_packet.dart';
import 'package:nexum_core/channel/packets/sync_data_packet.dart';

bool _alreadyRun = false;

void runApp(Widget widget) async {
  if(_alreadyRun) throw "Já está em execução";
  _alreadyRun = true;

  final PacketManager packetManager = PacketManager.initialize();

  final Channel channel = Channel.initialize(packetManager: packetManager);

  channel.start();
  HeartbeatMonitor.start();

  final SyncDataPacket response = await packetManager.sendPacketAndWaitResponse(RequestDataSyncPacket());

  final Nexum nexum = Nexum.initialize(
    fpsLimit: response.fpsLimit,
    screenSize: response.screenSize,
  );

  nexum.start(widget);
}
