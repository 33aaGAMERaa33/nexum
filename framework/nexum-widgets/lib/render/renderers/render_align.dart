import 'dart:math';

import 'package:meta/meta.dart';
import 'package:nexum_core/material/alignament.dart';
import 'package:nexum_core/material/get_child_paint_command.dart';
import 'package:nexum_core/material/paint_command.dart';
import 'package:nexum_core/material/paint_command_recorder.dart';
import 'package:nexum_core/material/render_box.dart';
import 'package:nexum_core/models/offset.dart';
import 'package:nexum_core/models/size.dart';
import 'package:nexum_core/render/commands/paint_single_child_command.dart';
import 'package:nexum_core/render/mixins/single_child_render_object.dart';

class RenderAlign extends RenderBox with SingleChildRenderObject {
  Alignment alignment;
  Offset ? _alignedOffset;

  @override
  @protected
  RenderBox get child => super.child! as RenderBox;

  RenderAlign(this.alignment);

  @override
  void paint(PaintCommandRecorder paintRecorder, Offset offset) {
    if(!needsPaint) return;
    needsPaint = false;

    if(parent == null) absoluteOffset = offset;
    child.absoluteOffset = absoluteOffset + _alignedOffset!;
    relativeOffset = offset;

    final GetChildPaintCommand childPaintCommandGetter = GetChildPaintCommand();
    child.paint(childPaintCommandGetter, Offset.zero());

    final PaintCommand paintCommand = PaintSingleChildCommand(
      owner: this,
      size: size,
      offset: offset + _alignedOffset!,
      child: childPaintCommandGetter.getChildPaintCommand(),
    );

    this.paintCommand = paintCommand;

    paintRecorder.register(paintCommand);
  }

  @override
  void performLayout() {
    child.layout(constraints);

    final Size childSize = child.size;
    final int width = constraints.hasBoundedWidth ? constraints.maxWidth : child.size.width;
    final int height = constraints.hasBoundedHeight ? constraints.maxHeight : child.size.height;

    final int alignedX = ((width - childSize.width) * alignment.xFactor).toInt();
    final int alignedY = ((height - childSize.height) * alignment.yFactor).toInt();

    size = Size(
        width: width,
        height: height
    );

    _alignedOffset = Offset(
        leftPos: min(alignedX, width),
        topPos: min(alignedY, height),
    );
  }

  @override
  Future<void> prepareLayout() => child.prepareLayout();

  @override
  bool get needsChildLayout => true;
}
