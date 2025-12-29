import 'package:nexum_core/models/size.dart';
import 'package:nexum_core/channel/friendly_buffer.dart';
import 'package:nexum_core/channel/packet_deserializer.dart';
import 'package:nexum_core/channel/packets/sync_data_packet.dart';

class SyncDataPacketDeserializer extends PacketDeserializer<SyncDataPacket> {
  @override
  String get identifier => "sync_data";

  @override
  Type get packetType => SyncDataPacket;

  @override
  SyncDataPacket deserialize(FriendlyBuffer friendlyBuffer) {
    final int width = friendlyBuffer.readInt();
    final int height = friendlyBuffer.readInt();
    final int fpsLimit = friendlyBuffer.readInt();

    return SyncDataPacket(
        fpsLimit: fpsLimit,
        screenSize: Size(width: width, height: height),
    );
  }
}