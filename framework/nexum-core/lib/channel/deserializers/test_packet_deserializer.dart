import 'package:nexum_core/core/services/helper_deserializer_service.dart';
import 'package:nexum_core/material/test_object.dart';
import 'package:nexum_core/channel/friendly_buffer.dart';
import 'package:nexum_core/channel/packet_deserializer.dart';
import 'package:nexum_core/channel/packets/test_packet.dart';

class TestPacketDeserializer extends PacketDeserializer<TestPacket> {
  @override
  String get identifier => "test";

  @override
  Type get packetType => TestPacket;

  @override
  TestPacket deserialize(FriendlyBuffer friendlyBuffer) {
    final TestObject testObject = HelperDeserializerService.instance.deserializeObject(friendlyBuffer);
    return TestPacket(testObject);
  }
}