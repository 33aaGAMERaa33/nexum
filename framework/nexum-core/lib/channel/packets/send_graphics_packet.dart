import 'package:nexum_core/channel/packet.dart';
import 'package:nexum_core/render/graphics.dart';

class SendGraphicsPacket extends Packet {
  final Graphics graphics;
  SendGraphicsPacket(this.graphics);
}