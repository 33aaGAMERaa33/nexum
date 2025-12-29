import 'package:nexum_core/models/offset.dart';
import 'package:nexum_core/render/graphics_instruction.dart';

class TranslateInstruction extends GraphicsInstruction {
  final Offset offset;
  TranslateInstruction(this.offset);
}