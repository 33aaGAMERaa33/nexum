import 'package:nexum_core/material/test_object.dart';
import 'package:nexum_core/channel/packet.dart';

class TestPacket extends Packet {
  final TestObject testObject;
  TestPacket(this.testObject);

  @override
  String toString() => "TestPacket(testObject: $testObject)";
}