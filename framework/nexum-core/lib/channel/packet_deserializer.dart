import 'package:nexum_core/channel/friendly_buffer.dart';
import 'package:nexum_core/channel/packet.dart';

abstract class PacketDeserializer<T extends Packet> {
  String get identifier;
  Type get packetType;
  T deserialize(FriendlyBuffer friendlyBuffer);
}