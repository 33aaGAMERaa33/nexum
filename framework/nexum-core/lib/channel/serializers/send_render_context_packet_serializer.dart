import 'package:nexum_core/core/services/helper_serializer_service.dart';
import 'package:nexum_core/channel/friendly_buffer.dart';
import 'package:nexum_core/channel/packet_serializer.dart';
import 'package:nexum_core/channel/packets/send_render_context_packet.dart';

class SendRenderContextPacketSerializer extends PacketSerializer<SendRenderContextPacket>{
  @override
  String get identifier => "send_render_context";

  @override
  Type get packetType => SendRenderContextPacket;

  @override
  void serialize(SendRenderContextPacket packet, FriendlyBuffer friendlyBuffer) {
    HelperSerializerService.instance.serializeObject(packet.renderContext, friendlyBuffer);
  }
}