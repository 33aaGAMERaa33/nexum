import 'package:nexum_core/models/color.dart';
import 'package:nexum_core/render/graphics_instruction.dart';

class SetColorInstruction extends GraphicsInstruction {
  final Color color;
  SetColorInstruction(this.color);
}