import 'package:nexum_core/core/services/helper_deserializer_service.dart';
import 'package:nexum_core/channel/friendly_buffer.dart';
import 'package:nexum_core/channel/packet_deserializer.dart';
import 'package:nexum_core/channel/packets/send_text_metrics_packet.dart';

class SendTextMetricsPacketDeserializer extends PacketDeserializer<SendTextMetricsPacket> {
  @override
  String get identifier => "send_text_metrics";

  @override
  Type get packetType => SendTextMetricsPacket;

  @override
  SendTextMetricsPacket deserialize(FriendlyBuffer friendlyBuffer) {

    return SendTextMetricsPacket(
      HelperDeserializerService.instance.deserializeObject(friendlyBuffer),
    );
  }
}