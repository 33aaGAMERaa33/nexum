import 'package:nexum_core/material/font.dart';
import 'package:nexum_core/material/paint_command.dart';
import 'package:nexum_core/models/color.dart';
import 'package:nexum_core/models/offset.dart';
import 'package:nexum_core/render/graphics.dart';

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
  void paint(Graphics graphics) {
    graphics.translate(offset);
    graphics.clipRect(Offset.zero(), size);

    graphics.setFont(font);
    graphics.setColor(color);
    graphics.drawString(value);
  }
}