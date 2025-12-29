import 'package:nexum_core/channel/friendly_buffer.dart';
import 'package:nexum_core/channel/packet_deserializer.dart';
import 'package:nexum_core/channel/packets/start_packet.dart';

class StartNexumPacketDeserializer extends PacketDeserializer<StartPacket> {
  @override
  StartPacket deserialize(FriendlyBuffer friendlyBuffer) {
    return StartPacket();
  }

  @override
  String get identifier => "start";

  @override
  Type get packetType => StartPacket;

}