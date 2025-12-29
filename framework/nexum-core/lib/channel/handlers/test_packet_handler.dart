import 'package:nexum_core/channel/packet_handler.dart';
import 'package:nexum_core/channel/packets/test_packet.dart';

class TestPacketHandler extends PacketHandler<TestPacket> {
  @override
  Type get packetType => TestPacket;

  @override
  void handle(TestPacket packet) async {

  }
}