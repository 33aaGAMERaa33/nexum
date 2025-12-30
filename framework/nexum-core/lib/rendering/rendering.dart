import '../painting/geometry.dart';
import '../ui/color.dart';
import '../ui/font.dart';

abstract class RenderInstruction {

}

class CreateNewContextInstruction extends RenderInstruction {
  RenderContext get renderContext => _renderContext;
  final RenderContext _renderContext = RenderContext();
}

class CreateSubContextInstruction extends CreateNewContextInstruction {
  CreateSubContextInstruction();
}

class ClipRectInstruction extends RenderInstruction {
  final Size size;
  final Offset offset;

  ClipRectInstruction(this.offset, this.size);
}

class TranslateInstruction extends RenderInstruction {
  final Offset offset;
  TranslateInstruction(this.offset);
}

class SetFontInstruction extends RenderInstruction {
  final Font font;
  SetFontInstruction(this.font);
}

class SetCompositeInstruction extends RenderInstruction {
  final double alpha;
  SetCompositeInstruction(this.alpha);
}

class SetColorInstruction extends RenderInstruction {
  final Color color;
  SetColorInstruction(this.color);
}

class DrawStringInstruction extends RenderInstruction {
  final String string;
  DrawStringInstruction(this.string);
}

class DrawRectInstruction extends RenderInstruction {
  final Size size;

  DrawRectInstruction(Size size) : size = Size(
      width: size.width - 1, height: size.height - 1
  );
}

class RenderContext {
  final List<RenderInstruction> _instructions = [];
  List<RenderInstruction> get instructions => _instructions;

  RenderContext();

  void _addInstruction(RenderInstruction instruction) => _instructions.insert(0, instruction);

  void solve() {
    print(_instructions);

    for(final RenderInstruction instruction in _instructions) {
      if(instruction is CreateNewContextInstruction) {
        instruction.renderContext.solve();
      }
    }
  }

  RenderContext create() {
    final CreateSubContextInstruction instruction = CreateSubContextInstruction();
    _addInstruction(instruction);

    return instruction.renderContext;
  }

  RenderContext createScoped(Offset offset, Size size) {
    final CreateSubContextInstruction instruction = CreateSubContextInstruction();
    _addInstruction(instruction);

    instruction.renderContext.translate(offset);
    instruction.renderContext.clipRect(Offset.zero(), size);

    return instruction.renderContext;
  }

  void setFont(Font font) => _addInstruction(SetFontInstruction(font));
  void setColor(Color color) => _addInstruction(SetColorInstruction(color));
  void translate(Offset offset) => _addInstruction(TranslateInstruction(offset));
  void drawString(String string) => _addInstruction(DrawStringInstruction(string));
  void setComposite(double alpha) => _addInstruction(SetCompositeInstruction(alpha));
  void drawRect(Offset offset, Size size) => _addInstruction(DrawRectInstruction(size));
  void clipRect(Offset offset, Size size) => _addInstruction(ClipRectInstruction(offset, size));
}