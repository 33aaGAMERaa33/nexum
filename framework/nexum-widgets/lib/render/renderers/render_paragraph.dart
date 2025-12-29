import 'package:nexum_core/material/paint_command.dart';
import 'package:nexum_core/material/paint_command_recorder.dart';
import 'package:nexum_core/material/render_box.dart';
import 'package:nexum_core/material/text_style.dart';
import 'package:nexum_core/models/offset.dart';
import 'package:nexum_core/channel/packet_manager.dart';
import 'package:nexum_core/channel/packets/request_text_metrics_packet.dart';
import 'package:nexum_core/channel/packets/send_text_metrics_packet.dart';
import 'package:nexum_core/render/commands/paint_paragraph_command.dart';

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