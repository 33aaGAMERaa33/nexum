import 'package:nexum_core/material/paint_command.dart';
import 'package:nexum_core/material/paint_command_recorder.dart';

class GetChildPaintCommand extends PaintCommandRecorder {
  PaintCommand ? _paintCommand;

  @override
  void register(PaintCommand paintCommand) => _paintCommand = paintCommand;
  PaintCommand ? getChildPaintCommand() => _paintCommand;
}