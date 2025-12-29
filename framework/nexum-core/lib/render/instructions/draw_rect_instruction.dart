import 'package:nexum_core/models/offset.dart';
import 'package:nexum_core/models/size.dart';
import 'package:nexum_core/render/graphics_instruction.dart';

class DrawRectInstruction extends GraphicsInstruction {
  final Offset offset;
  final Size size;

  DrawRectInstruction(this.offset, Size size) : size = Size(
      width: size.width - 1, height: size.height - 1
  );
}