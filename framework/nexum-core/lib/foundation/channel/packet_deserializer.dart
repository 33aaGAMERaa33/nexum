import 'package:nexum_core/foundation/channel/packet.dart';

import 'friendly_buffer.dart';

abstract class PacketDeserializer<T extends Packet> {
  String get identifier;
  Type get packetType;
  T deserialize(FriendlyBuffer friendlyBuffer);
}