import 'package:nexum_core/channel/friendly_buffer.dart';
import 'package:nexum_core/channel/packet_serializer.dart';
import 'package:nexum_core/channel/packets/ready_to_start_packet.dart';

class ReadyToStartPacketSerializer extends PacketSerializer<ReadyToStartPacket> {
  @override
  void serialize(ReadyToStartPacket packet, FriendlyBuffer friendlyBuffer) {
  }

  @override
  String get identifier => "ready_to_start";

  @override
  Type get packetType => ReadyToStartPacket;
}