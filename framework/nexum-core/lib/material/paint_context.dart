import 'package:nexum_core/render/render_context.dart';
import 'package:nexum_core/material/paint_command.dart';
import 'package:nexum_core/material/paint_command_recorder.dart';

class PaintContext implements PaintCommandRecorder {
  final List<PaintCommand> paintCommands = [];

  void paint(RenderContext renderContext) {
    for(final PaintCommand paintCommand in paintCommands) {
      final RenderContext subContext = renderContext.create();
      paintCommand.paint(subContext);
    }
  }

  @override
  void register(PaintCommand paintCommand) {
    if(paintCommands.contains(paintCommand)) return;
    paintCommands.add(paintCommand);
  }
}