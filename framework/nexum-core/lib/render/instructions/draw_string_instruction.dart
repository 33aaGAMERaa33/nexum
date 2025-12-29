import 'package:nexum_core/render/graphics_instruction.dart';

class DrawStringInstruction extends GraphicsInstruction {
  final String string;
  DrawStringInstruction(this.string);
}