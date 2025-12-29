import 'package:nexum_core/models/offset.dart';
import 'package:nexum_core/models/size.dart';
import 'package:nexum_core/render/render_instruction.dart';

class DrawRectInstruction extends RenderInstruction {
  final Size size;

  DrawRectInstruction(Size size) : size = Size(
      width: size.width - 1, height: size.height - 1
  );
}