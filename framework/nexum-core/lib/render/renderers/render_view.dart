import 'package:nexum_core/material/paint_command_recorder.dart';
import 'package:nexum_core/material/render_box.dart';
import 'package:nexum_core/models/offset.dart';
import 'package:nexum_core/models/size.dart';
import 'package:nexum_core/render/mixins/single_child_render_object.dart';

import '../../material/render_object.dart';

class RenderView extends RenderBox with SingleChildRenderObject {
  @override
  RenderObject get child => super.child!;

  @override
  void paint(PaintCommandRecorder paintRecorder, Offset offset) {
    if(!needsPaint) return;
    needsPaint = false;

    if(parent == null) absoluteOffset = offset;
    child.absoluteOffset = absoluteOffset;
    relativeOffset = offset;

    child.paint(paintRecorder, offset);
  }

  @override
  void performLayout() {
    child.layout(constraints);
    size = Size(width: constraints.maxWidth, height: constraints.maxHeight);
  }

  @override
  Future<void> prepareLayout() => child.prepareLayout();

  @override
  bool get needsChildLayout => false;
}