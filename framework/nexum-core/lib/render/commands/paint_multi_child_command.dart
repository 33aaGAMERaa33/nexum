import 'package:nexum_core/material/paint_command.dart';
import 'package:nexum_core/models/offset.dart';
import 'package:nexum_core/render/graphics.dart';

class PaintMultiChildCommand extends PaintCommand {
  final List<PaintCommand> childrens;

  PaintMultiChildCommand({
    required super.owner,
    required super.size,
    required super.offset,
    required this.childrens
  });


  @override
  void paint(Graphics graphics) {
    graphics.translate(offset);
    graphics.clipRect(Offset.zero(), size);

    for(final PaintCommand child in childrens) {
      final Graphics subGraphics = graphics.create();
      child.paint(subGraphics);
    }
  }
}