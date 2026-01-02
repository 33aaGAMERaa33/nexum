import 'package:nexum_core/painting/geometry.dart';
import 'package:nexum_core/rendering/painting.dart';
import 'package:nexum_core/rendering/rendering.dart';
import 'package:nexum_core/ui/color.dart';

import '../../material/colors.dart';

class PaintRectCommand extends PaintCommand {
  final Color color;

  PaintRectCommand({
    required super.owner,
    required super.size,
    required super.offset,
    this.color = Colors.black,
  });

  @override
  void paint(RenderContext renderContext) {
    renderContext.translate(offset);
    renderContext.clipRect(Offset.zero(), size);

    renderContext.setColor(color);
    renderContext.drawRect(size);
  }
}