import 'package:nexum_core/material/colors.dart';
import 'package:nexum_core/material/get_child_paint_command.dart';
import 'package:nexum_core/material/paint_command_recorder.dart';
import 'package:nexum_core/material/render_box.dart';
import 'package:nexum_core/models/offset.dart';
import 'package:nexum_core/models/size.dart';
import 'package:nexum_core/render/commands/paint_multi_child_command.dart';
import 'package:nexum_core/render/render_context.dart';
import 'package:nexum_core/render/mixins/single_child_render_object.dart';
import 'package:nexum_core/render/commands/paint_by_render_context.dart';

class RenderDebugBox extends RenderBox with SingleChildRenderObject {
  @override
  void paint(PaintCommandRecorder paintRecorder, Offset offset) {
    if(!needsPaint) return;
    needsPaint = false;

    if(parent == null) absoluteOffset = offset;
    child.absoluteOffset = absoluteOffset;
    relativeOffset = offset;

    final GetChildPaintCommand childPaintCommandGetter = GetChildPaintCommand();

    child.paint(childPaintCommandGetter, Offset.zero());
    
    final PaintMultiChildCommand paintCommand = PaintMultiChildCommand(
        owner: this, offset: offset, size: size,
        childrens: [
          if(childPaintCommandGetter.getChildPaintCommand() != null)
            childPaintCommandGetter.getChildPaintCommand()!,
          PaintByRenderContext(
            owner: this, offset: offset, size: size,
            renderContext: RenderContext()
              ..setColor(Colors.black)
              ..drawRect(Offset.zero(), size)
          )
        ]
    );

    this.paintCommand = paintCommand;

    paintRecorder.register(paintCommand);
  }

  @override
  void performLayout() {
    child.layout(constraints);
    size = Size(width: child.size.width, height: child.size.height);
  }

  @override
  Future<void> prepareLayout() => child.prepareLayout();

  @override
  RenderBox get child => super.child! as RenderBox;

  @override
  bool get needsChildLayout => true;
}