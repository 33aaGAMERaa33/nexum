import 'package:nexum_core/material/font.dart';
import 'package:nexum_core/material/paint_command.dart';
import 'package:nexum_core/models/color.dart';
import 'package:nexum_core/models/offset.dart';
import 'package:nexum_core/render/render_context.dart';

class PaintParagraphCommand extends PaintCommand {
  final Font font;
  final Color color;
  final String value;

  PaintParagraphCommand({
    required super.owner,
    required super.size,
    required super.offset,
    required this.value,
    required this.font,
    required this.color,
  });

  @override
  void paint(RenderContext renderContext) {
    renderContext.translate(offset);
    renderContext.clipRect(Offset.zero(), size);

    renderContext.setFont(font);
    renderContext.setColor(color);
    renderContext.drawString(value);
  }
}