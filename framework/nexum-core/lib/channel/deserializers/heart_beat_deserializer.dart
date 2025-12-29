import 'package:nexum_core/channel/friendly_buffer.dart';
import 'package:nexum_core/channel/packets/heart_beat_packet.dart';
import 'package:nexum_core/channel/packet_deserializer.dart';

class HeartBeatDeserializer extends PacketDeserializer<HeartBeatPacket> {
  @override
  HeartBeatPacket deserialize(FriendlyBuffer friendlyBuffer) {
    return HeartBeatPacket();
  }

  @override
  String get identifier => "heart_beat";

  @override
  Type get packetType => HeartBeatPacket;
}