import 'package:nexum_core/material/font.dart';
import 'package:nexum_core/render/graphics_instruction.dart';

class SetFontInstruction extends GraphicsInstruction {
  final Font font;
  SetFontInstruction(this.font);
}