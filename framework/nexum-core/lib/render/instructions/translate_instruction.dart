import 'package:nexum_core/models/offset.dart';
import 'package:nexum_core/render/render_instruction.dart';

class TranslateInstruction extends RenderInstruction {
  final Offset offset;
  TranslateInstruction(this.offset);
}