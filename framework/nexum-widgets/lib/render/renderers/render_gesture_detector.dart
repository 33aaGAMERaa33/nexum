import 'package:nexum_core/material/get_child_paint_command.dart';
import 'package:nexum_core/material/paint_command_recorder.dart';
import 'package:nexum_core/material/render_box.dart';
import 'package:nexum_core/models/offset.dart';
import 'package:nexum_core/render/commands/paint_single_child_command.dart';
import 'package:nexum_core/render/mixins/on_pointer_tap.dart';
import 'package:nexum_core/render/mixins/single_child_render_object.dart';
import 'package:nexum_core/types/void_callback.dart';

class RenderGestureDetector extends RenderBox with SingleChildRenderObject, OnPointerTap {
  VoidCallback onTapCallback;
  RenderGestureDetector(this.onTapCallback);

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
    child.layout(constraints);
    size = child.size;
  }

  @override
  Future<void> prepareLayout() => child.prepareLayout();

  @override
  void onTap() {
    onTapCallback.call();
  }

  @override
  bool get needsChildLayout => true;

  @override
  RenderBox get child => super.child! as RenderBox;
}