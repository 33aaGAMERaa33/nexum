import 'package:nexum_core/render/graphics_instruction.dart';

class SetCompositeInstruction extends GraphicsInstruction {
  final double alpha;
  SetCompositeInstruction(this.alpha);
}