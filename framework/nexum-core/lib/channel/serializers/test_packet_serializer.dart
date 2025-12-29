import 'package:nexum_core/core/services/helper_serializer_service.dart';
import 'package:nexum_core/channel/friendly_buffer.dart';
import 'package:nexum_core/channel/packet_serializer.dart';
import 'package:nexum_core/channel/packets/test_packet.dart';

class TestPacketSerializer extends PacketSerializer<TestPacket> {
  @override
  String get identifier => "test";

  @override
  Type get packetType => TestPacket;

  @override
  void serialize(TestPacket packet, FriendlyBuffer friendlyBuffer) {
    HelperSerializerService.instance.serializeObject(packet.testObject, friendlyBuffer);
  }
}