import 'package:collection/collection.dart';

import '../painting/geometry.dart';
import '../ui/color.dart';
import '../ui/font.dart';

@immutable
abstract class RenderInstruction {

}

abstract class CreateContextInstruction extends RenderInstruction {
  final RenderContext _renderContext;
  CreateContextInstruction(this._renderContext);
  RenderContext get renderContext => _renderContext;

  @override
  bool operator ==(Object other) {
    return other is CreateContextInstruction && other.renderContext == renderContext;
  }

  @override
  int get hashCode => Object.hash(runtimeType, renderContext);
}

class CreateNewContextInstruction extends CreateContextInstruction {
  CreateNewContextInstruction(super.renderContext);
}

class CreateSubContextInstruction extends CreateContextInstruction {
  CreateSubContextInstruction(super.renderContext);
}

class ClipRectInstruction extends RenderInstruction {
  final Size size;
  final Offset offset;

  ClipRectInstruction(this.offset, this.size);

  @override
  bool operator ==(Object other) {
    return other is ClipRectInstruction && other.size == size && other.offset == offset;
  }

  @override
  int get hashCode => Object.hash(size, offset);
}

class DrawStringInstruction extends RenderInstruction {
  final String string;
  DrawStringInstruction(this.string);

  @override
  bool operator ==(Object other) {
    return other is DrawStringInstruction && other.string == string;
  }

  @override
  int get hashCode => Object.hash(runtimeType, string);
}

class DrawRectInstruction extends RenderInstruction {
  final Size size;

  DrawRectInstruction(Size size) : size = Size(
      width: size.width - 1, height: size.height - 1
  );

  @override
  bool operator ==(Object other) {
    return other is DrawRectInstruction && other.size == size;
  }

  @override
  int get hashCode => Object.hash(runtimeType, size);
}

class TranslateInstruction extends RenderInstruction {
  final Offset offset;
  TranslateInstruction(this.offset);

  @override
  bool operator ==(Object other) {
    return other is TranslateInstruction && other.offset == offset;
  }

  @override
  int get hashCode => Object.hash(runtimeType, offset);
}

class SetFontInstruction extends RenderInstruction {
  final Font font;
  SetFontInstruction(this.font);

  @override
  bool operator ==(Object other) {
    return other is SetFontInstruction && other.font == font;
  }

  @override
  int get hashCode => Object.hash(runtimeType, font);
}

class SetColorInstruction extends RenderInstruction {
  final Color color;
  SetColorInstruction(this.color);

  @override
  bool operator ==(Object other) {
    return other is SetColorInstruction && other.color == color;
  }

  @override
  int get hashCode => Object.hash(runtimeType, color);
}

class SetCompositeInstruction extends RenderInstruction {
  final double alpha;
  SetCompositeInstruction(this.alpha);

  @override
  bool operator ==(Object other) {
    return other is SetCompositeInstruction && other.alpha == alpha;
  }

  @override
  int get hashCode => Object.hash(runtimeType, alpha);
}

class RenderContext {
  static const _eq = ListEquality();
  
  final RenderContext ? _parent;
  final List<RenderInstruction> _instructions = [];
  
  RenderContext() : _parent = null;
  
  RenderContext._(RenderContext parent) : _parent = parent;

  List<RenderInstruction> get instructions => _instructions;

  void _addInstruction(RenderInstruction instruction) {
    if(_instructions.contains(instruction)) return;
    _instructions.add(instruction);
  }

  RenderContext create() {
    final RenderContext renderContext = RenderContext._(this);
    _addInstruction(CreateSubContextInstruction(renderContext));

    return renderContext;
  }

  RenderContext createScoped(Offset offset, Size size) {
    final RenderContext renderContext = RenderContext();

    renderContext.translate(offset);
    renderContext.clipRect(Offset.zero(), size);

    return renderContext;
  }

  void setFont(Font font) => _addInstruction(SetFontInstruction(font));
  void drawRect(Size size) => _addInstruction(DrawRectInstruction(size));
  void setColor(Color color) => _addInstruction(SetColorInstruction(color));
  void translate(Offset offset) => _addInstruction(TranslateInstruction(offset));
  void drawString(String string) => _addInstruction(DrawStringInstruction(string));
  void setComposite(double alpha) => _addInstruction(SetCompositeInstruction(alpha));
  void clipRect(Offset offset, Size size) => _addInstruction(ClipRectInstruction(offset, size));

  @override
  bool operator ==(Object other) {
    return other is RenderContext && _eq.equals(other._instructions, _instructions);
  }

  @override
  int get hashCode => Object.hash(runtimeType, _eq.hash(_instructions));
}