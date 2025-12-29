import 'package:nexum_core/models/color.dart';
import 'package:nexum_core/render/render_instruction.dart';

class SetColorInstruction extends RenderInstruction {
  final Color color;
  SetColorInstruction(this.color);
}