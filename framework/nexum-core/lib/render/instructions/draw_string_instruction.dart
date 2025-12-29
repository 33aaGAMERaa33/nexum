import 'package:nexum_core/render/render_instruction.dart';

class DrawStringInstruction extends RenderInstruction {
  final String string;
  DrawStringInstruction(this.string);
}