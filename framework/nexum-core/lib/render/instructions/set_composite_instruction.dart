import 'package:nexum_core/render/render_instruction.dart';

class SetCompositeInstruction extends RenderInstruction {
  final double alpha;
  SetCompositeInstruction(this.alpha);
}