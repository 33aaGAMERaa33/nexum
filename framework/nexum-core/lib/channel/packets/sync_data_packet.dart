import 'package:nexum_core/models/size.dart';
import 'package:nexum_core/channel/packet.dart';

class SyncDataPacket extends Packet {
  final int fpsLimit;
  final Size screenSize;

  SyncDataPacket({
    required this.fpsLimit,
    required this.screenSize,
  });

  @override
  String toString() => "SyncDataPacket(fpsLimit: $fpsLimit, screenSize: $screenSize)";
}