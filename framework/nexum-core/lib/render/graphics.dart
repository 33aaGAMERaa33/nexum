import 'package:nexum_core/material/font.dart';
import 'package:nexum_core/models/color.dart';
import 'package:nexum_core/models/offset.dart';
import 'package:nexum_core/models/size.dart';
import 'package:nexum_core/render/graphics_instruction.dart';
import 'package:nexum_core/render/instructions/clip_rect_instruction.dart';
import 'package:nexum_core/render/instructions/create_graphics_instruction.dart';
import 'package:nexum_core/render/instructions/draw_rect_instruction.dart';
import 'package:nexum_core/render/instructions/draw_string_instruction.dart';
import 'package:nexum_core/render/instructions/set_color_instruction.dart';
import 'package:nexum_core/render/instructions/set_composite_instruction.dart';
import 'package:nexum_core/render/instructions/set_font_instruction.dart';
import 'package:nexum_core/render/instructions/translate_instruction.dart';

class Graphics {
  final List<GraphicsInstruction> _instructions = [];
  List<GraphicsInstruction> get instructions => _instructions;

  Graphics();

  void _addInstruction(GraphicsInstruction instruction) => _instructions.insert(0, instruction);

  Graphics create() {
    final CreateGraphicsInstruction instruction = CreateGraphicsInstruction();
    _addInstruction(instruction);

    return instruction.graphics;
  }

  Graphics createScoped(Offset offset, Size size) {
    final CreateGraphicsInstruction instruction = CreateGraphicsInstruction();
    _addInstruction(instruction);

    instruction.graphics.translate(offset);
    instruction.graphics.clipRect(Offset.zero(), size);

    return instruction.graphics;
  }

  void setFont(Font font) => _addInstruction(SetFontInstruction(font));
  void setColor(Color color) => _addInstruction(SetColorInstruction(color));
  void translate(Offset offset) => _addInstruction(TranslateInstruction(offset));
  void drawString(String string) => _addInstruction(DrawStringInstruction(string));
  void setComposite(double alpha) => _addInstruction(SetCompositeInstruction(alpha));
  void clipRect(Offset offset, Size size) => _addInstruction(ClipRectInstruction(offset, size));
  void drawRect(Offset offset, Size size) => _addInstruction(DrawRectInstruction(offset, size));
}