import 'package:nexum_core/material/get_child_paint_command.dart';
import 'package:nexum_core/material/max_int.dart';
import 'package:nexum_core/material/paint_command_recorder.dart';
import 'package:nexum_core/material/render_box.dart';
import 'package:nexum_core/models/constraints.dart';
import 'package:nexum_core/models/offset.dart';
import 'package:nexum_core/models/size.dart';
import 'package:nexum_core/render/commands/paint_single_child_command.dart';
import 'package:nexum_core/render/mixins/single_child_render_object.dart';

class RenderConstrainedBox extends RenderBox with SingleChildRenderObject {
  int ? width;
  int ? height;

  RenderConstrainedBox({
    required this.width,
    required this.height,
  });

  @override
  void paint(PaintCommandRecorder paintRecorder, Offset offset) {
    if(!needsPaint) return;
    needsPaint = false;

    if(parent == null) absoluteOffset = offset;
    child.absoluteOffset = absoluteOffset;
    relativeOffset = offset;

    final GetChildPaintCommand childPaintCommandGetter = GetChildPaintCommand();

    child.paint(childPaintCommandGetter, Offset.zero());

    final PaintSingleChildCommand paintCommand = PaintSingleChildCommand(
        owner: this, offset: offset, size: size,
        child: childPaintCommandGetter.getChildPaintCommand()
    );

    this.paintCommand = paintCommand;

    paintRecorder.register(paintCommand);
  }

  @override
  void performLayout() {
    child.layout(Constraints(maxWidth: width ?? maxInt, maxHeight: height ?? maxInt));
    size = Size(width: width ?? child.size.width, height: height ?? child.size.height);
  }

  @override
  Future<void> prepareLayout() => child.prepareLayout();

  @override
  bool get needsChildLayout => width == null || height == null;

  @override
  RenderBox get child => super.child! as RenderBox;
}