import 'package:nexum_core/material/paint_command.dart';
import 'package:nexum_core/models/offset.dart';
import 'package:nexum_core/render/graphics.dart';

class PaintSingleChildCommand extends PaintCommand {
  final PaintCommand ?  child;

  PaintSingleChildCommand({
    required super.owner,
    required super.size,
    required super.offset,
    required this.child,
  });

  @override
  void paint(Graphics graphics) {
    if(child == null) return;
    graphics.translate(offset);
    graphics.clipRect(Offset.zero(), size);

    child?.paint(graphics);
  }
}