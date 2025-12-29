import 'package:nexum_core/channel/friendly_buffer.dart';
import 'package:nexum_core/channel/packets/heart_beat_packet.dart';
import 'package:nexum_core/channel/packet_serializer.dart';

class HeartBeatPacketSerializer extends PacketSerializer<HeartBeatPacket> {
  @override
  void serialize(HeartBeatPacket packet, FriendlyBuffer friendlyBuffer) {
  }

  @override
  String get identifier => "heart_beat";

  @override
  Type get packetType => HeartBeatPacket;
}