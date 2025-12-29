import 'package:nexum_core/render/graphics.dart';
import 'package:nexum_core/material/paint_command.dart';
import 'package:nexum_core/material/paint_command_recorder.dart';

class PaintContext implements PaintCommandRecorder {
  final List<PaintCommand> paintCommands = [];

  void paint(Graphics graphics) {
    for(final PaintCommand paintCommand in paintCommands) {
      final Graphics subGraphics = graphics.create();
      paintCommand.paint(subGraphics);
    }
  }

  @override
  void register(PaintCommand paintCommand) {
    if(paintCommands.contains(paintCommand)) return;
    paintCommands.add(paintCommand);
  }
}