import 'package:nexum_core/channel/packet.dart';
import 'package:nexum_core/render/render_context.dart';

class SendRenderContextPacket extends Packet {
  final RenderContext renderContext;
  SendRenderContextPacket(this.renderContext);
}