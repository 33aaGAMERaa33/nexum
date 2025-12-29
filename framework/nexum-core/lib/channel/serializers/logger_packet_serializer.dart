import 'package:nexum_core/channel/friendly_buffer.dart';
import 'package:nexum_core/channel/packet_serializer.dart';
import 'package:nexum_core/channel/packets/logger_packet.dart';

class LoggerPacketSerializer extends PacketSerializer<LoggerPacket> {
  @override
  void serialize(LoggerPacket packet, FriendlyBuffer friendlyBuffer) {
    friendlyBuffer.writeString(packet.log);
    friendlyBuffer.writeString(packet.identifier);
    friendlyBuffer.writeString(packet.type.identifier);
  }

  @override
  String get identifier => "logger";

  @override
  Type get packetType => LoggerPacket;
}