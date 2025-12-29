import 'package:nexum_core/core/services/helper_serializer_service.dart';
import 'package:nexum_core/channel/friendly_buffer.dart';
import 'package:nexum_core/channel/packet_serializer.dart';
import 'package:nexum_core/channel/packets/send_graphics_packet.dart';

class SendGraphicsPacketSerializer extends PacketSerializer<SendGraphicsPacket>{
  @override
  String get identifier => "send_graphics";

  @override
  Type get packetType => SendGraphicsPacket;

  @override
  void serialize(SendGraphicsPacket packet, FriendlyBuffer friendlyBuffer) {
    HelperSerializerService.instance.serializeObject(packet.graphics, friendlyBuffer);
  }
}