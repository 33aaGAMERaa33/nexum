import '../../foundation/channel/packet_manager.dart';
import '../../foundation/channel/packets/metrics.dart';
import '../../painting/geometry.dart';
import '../../painting/text_style.dart';
import '../box.dart';
import '../commands/paint_paragraph_command.dart';
import '../painting.dart';

class RenderParagraph extends RenderBox {
  String value;
  TextStyle style;

  RenderParagraph({
    required this.value,
    required this.style,
  });

  @override
  void paint(PaintCommandRecorder paintRecorder, Offset offset) {
    if(!needsPaint) return;
    needsPaint = false;

    if(parent == null) absoluteOffset = offset;
    relativeOffset = offset;

    final PaintCommand paintCommand = PaintParagraphCommand(
      owner: this, size: size, offset: offset,
      value: value, font: style.font, color: style.color,
    );

    this.paintCommand = paintCommand;

    paintRecorder.register(paintCommand);
  }

  @override
  void performLayout() {

  }

  @override
  Future<void> prepareLayout() async {
    final SendTextMetricsPacket response = await PacketManager.instance.sendPacketAndWaitResponse(
        RequestTextMetricsPacket(value: value, style: style),
    );

    size = response.textMetrics.size;
  }

  @override
  bool get needsChildLayout => false;
}