import 'package:nexum_core/render/render_context.dart';
import 'package:nexum_core/render/render_instruction.dart';

class CreateSubContextInstruction extends RenderInstruction {
  RenderContext get renderContext => _renderContext;
  final RenderContext _renderContext = RenderContext();

  CreateSubContextInstruction();
}