import 'package:nexum_core/material/paint_command.dart';
import 'package:nexum_core/render/graphics.dart';

import '../../models/offset.dart';

class PaintByGraphics extends PaintCommand {
  final Graphics graphics;

  PaintByGraphics({
    required super.owner,
    required super.size,
    required super.offset,
    required this.graphics,
  });

  @override
  void paint(Graphics graphics) {
    graphics.translate(offset);
    graphics.clipRect(Offset.zero(), size);
    graphics.instructions.addAll(this.graphics.instructions);
  }
}