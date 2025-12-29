import 'package:nexum_core/models/offset.dart';
import 'package:nexum_core/models/size.dart';
import 'package:nexum_core/render/graphics_instruction.dart';

class ClipRectInstruction extends GraphicsInstruction {
  final Size size;
  final Offset offset;

  ClipRectInstruction(this.offset, this.size);
}