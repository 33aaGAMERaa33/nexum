import 'package:nexum_core/material/font.dart';
import 'package:nexum_core/render/render_instruction.dart';

class SetFontInstruction extends RenderInstruction {
  final Font font;
  SetFontInstruction(this.font);
}