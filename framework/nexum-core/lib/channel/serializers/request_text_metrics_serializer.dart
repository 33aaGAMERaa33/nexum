import 'package:nexum_core/channel/friendly_buffer.dart';
import 'package:nexum_core/channel/packet_serializer.dart';
import 'package:nexum_core/channel/packets/request_text_metrics_packet.dart';

class RequestTextMetricsSerializer extends PacketSerializer<RequestTextMetricsPacket> {
  @override
  String get identifier => "request_text_metrics";

  @override
  Type get packetType => RequestTextMetricsPacket;

  @override
  void serialize(RequestTextMetricsPacket packet, FriendlyBuffer friendlyBuffer) {
    friendlyBuffer.writeString(packet.value);
    friendlyBuffer.writeInt(packet.style.font.fontSize);
  }
}