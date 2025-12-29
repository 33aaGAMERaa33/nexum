import 'package:nexum_core/channel/friendly_buffer.dart';
import 'package:nexum_core/channel/packet.dart';

abstract class PacketSerializer<T extends Packet> {
  String get identifier;
  Type get packetType;
  void serialize(T packet, FriendlyBuffer friendlyBuffer);
}