import 'package:nexum_core/material/edge_insets.dart';
import 'package:nexum_core/material/get_child_paint_command.dart';
import 'package:nexum_core/material/paint_command_recorder.dart';
import 'package:nexum_core/material/render_box.dart';
import 'package:nexum_core/models/constraints.dart';
import 'package:nexum_core/models/offset.dart';
import 'package:nexum_core/models/size.dart';
import 'package:nexum_core/render/commands/paint_single_child_command.dart';
import 'package:nexum_core/render/mixins/single_child_render_object.dart';

class RenderPadding extends RenderBox with SingleChildRenderObject {
  EdgeInsets edgeInsets;
  Offset ? translatedOffset;
  RenderPadding(this.edgeInsets);

  @override
  void paint(PaintCommandRecorder paintRecorder, Offset offset) {
    if(!needsPaint) return;
    needsPaint = false;

    if(parent == null) absoluteOffset = offset;
    child.absoluteOffset = absoluteOffset + translatedOffset!;
    relativeOffset = offset;

    final GetChildPaintCommand childPaintCommandGetter = GetChildPaintCommand();

    child.paint(childPaintCommandGetter, translatedOffset!);

    final PaintSingleChildCommand paintCommand = PaintSingleChildCommand(
        owner: this, offset: offset, size: size,
        child: childPaintCommandGetter.getChildPaintCommand()
    );

    this.paintCommand = paintCommand;

    paintRecorder.register(paintCommand);
  }

  @override
  void performLayout() {
    child.layout(Constraints(
        maxWidth: constraints.maxWidth - edgeInsets.horizontalSize,
        maxHeight: constraints.maxHeight - edgeInsets.verticalSize,
    ));

    size = Size(
        width: child.size.width + edgeInsets.horizontalSize,
        height: child.size.height + edgeInsets.verticalSize,
    );

    translatedOffset = Offset(leftPos: edgeInsets.left, topPos: edgeInsets.top);
  }

  @override
  Future<void> prepareLayout() => child.prepareLayout();

  @override
  RenderBox get child => super.child! as RenderBox;

  @override
  bool get needsChildLayout => true;
}