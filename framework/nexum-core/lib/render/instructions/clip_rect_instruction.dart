import 'package:nexum_core/models/offset.dart';
import 'package:nexum_core/models/size.dart';
import 'package:nexum_core/render/render_instruction.dart';

class ClipRectInstruction extends RenderInstruction {
  final Size size;
  final Offset offset;

  ClipRectInstruction(this.offset, this.size);
}