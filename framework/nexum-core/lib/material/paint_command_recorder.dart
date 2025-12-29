import 'package:nexum_core/material/paint_command.dart';

abstract class PaintCommandRecorder {
  void register(PaintCommand paintCommand);
}