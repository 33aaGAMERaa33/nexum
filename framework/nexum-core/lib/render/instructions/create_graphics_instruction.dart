import 'package:nexum_core/render/graphics.dart';
import 'package:nexum_core/render/graphics_instruction.dart';

class CreateGraphicsInstruction extends GraphicsInstruction {
  Graphics get graphics => _graphics;
  final Graphics _graphics = Graphics();

  CreateGraphicsInstruction();
}