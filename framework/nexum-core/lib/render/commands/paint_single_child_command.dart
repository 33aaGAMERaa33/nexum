import 'package:nexum_core/material/paint_command.dart';
import 'package:nexum_core/models/offset.dart';
import 'package:nexum_core/render/render_context.dart';

class PaintSingleChildCommand extends PaintCommand {
  final PaintCommand ?  child;

  PaintSingleChildCommand({
    required super.owner,
    required super.size,
    required super.offset,
    required this.child,
  });

  @override
  void paint(RenderContext renderContext) {
    if(child == null) return;
    renderContext.translate(offset);
    renderContext.clipRect(Offset.zero(), size);

    child?.paint(renderContext);
  }
}