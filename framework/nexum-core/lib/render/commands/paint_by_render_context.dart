import 'package:nexum_core/material/paint_command.dart';
import 'package:nexum_core/render/render_context.dart';

import '../../models/offset.dart';

class PaintByRenderContext extends PaintCommand {
  final RenderContext renderContext;

  PaintByRenderContext({
    required super.owner,
    required super.size,
    required super.offset,
    required this.renderContext,
  });

  @override
  void paint(RenderContext renderContext) {
    renderContext.translate(offset);
    renderContext.clipRect(Offset.zero(), size);
    renderContext.instructions.addAll(this.renderContext.instructions);
  }
}