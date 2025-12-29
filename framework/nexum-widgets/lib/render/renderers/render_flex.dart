import 'dart:math';

import 'package:nexum_core/material/direction.dart';
import 'package:nexum_core/material/get_child_paint_command.dart';
import 'package:nexum_core/material/main_axis_alignment.dart';
import 'package:nexum_core/material/main_axis_size.dart';
import 'package:nexum_core/material/max_int.dart';
import 'package:nexum_core/material/paint_command.dart';
import 'package:nexum_core/material/paint_command_recorder.dart';
import 'package:nexum_core/material/render_box.dart';
import 'package:nexum_core/material/render_object.dart';
import 'package:nexum_core/models/constraints.dart';
import 'package:nexum_core/models/offset.dart';
import 'package:nexum_core/models/size.dart';
import 'package:nexum_core/render/commands/paint_multi_child_command.dart';
import 'package:nexum_core/render/mixins/multi_child_render_object.dart';

import 'render_flexible.dart';

class RenderFlex extends RenderBox with MultiChildRenderObject {
  int spacing;
  Direction direction;
  Size ? _childrensSize;
  MainAxisSize mainAxisSize;
  MainAxisAlignment mainAxisAlignment;

  RenderFlex({
    required this.spacing,
    required this.direction,
    required this.mainAxisSize,
    required this.mainAxisAlignment,
  });

  @override
  void paint(PaintCommandRecorder paintRecorder, Offset offset) {
    if(!needsPaint) return;
    needsPaint = false;

    if(parent == null) absoluteOffset = offset;
    relativeOffset = offset;

    int currentX = 0;
    int currentY = 0;
    final List<PaintCommand> childPaintCommands = [];

    for(int i = 0; i < childrens.length; i += 1) {
      final RenderBox child = childrens[i] as RenderBox;
      final GetChildPaintCommand childPaintCommandGetter = GetChildPaintCommand();

      Offset translateOffset = Offset(leftPos: currentX, topPos: currentY);
      int translateByMainAxisAlignmentValue = 0;

      final int containerSize = direction == Direction.horizontal ? size.width : size.height;
      final int childrenSize = direction == Direction.horizontal ? _childrensSize!.width : _childrensSize!.height;

      final int freeSpace = (containerSize - childrenSize).clamp(0, containerSize);

      switch (mainAxisAlignment) {
        case MainAxisAlignment.start:
          translateByMainAxisAlignmentValue = 0;
          break;
        case MainAxisAlignment.end:
          translateByMainAxisAlignmentValue = freeSpace;
          break;
        case MainAxisAlignment.center:
          translateByMainAxisAlignmentValue = (freeSpace / 2).toInt();
          break;
      }

      if(direction == Direction.horizontal) {
        translateOffset += Offset(leftPos: translateByMainAxisAlignmentValue, topPos: 0);
      }else {
        translateOffset += Offset(leftPos: 0, topPos: translateByMainAxisAlignmentValue);
      }

      child.absoluteOffset = absoluteOffset + translateOffset;
      child.paint(childPaintCommandGetter, translateOffset);

      childPaintCommands.add(child.paintCommand!);

      if(direction == Direction.horizontal) {
        currentX += child.size.width + spacing * (i + 1);
      }else {
        currentY += child.size.height + spacing * (i + 1);
      }
    }

    final PaintMultiChildCommand paintMultiChildCommand = PaintMultiChildCommand(
      owner: this,
      size: size,
      offset: offset,
      childrens: childPaintCommands,
    );

    paintCommand = paintMultiChildCommand;
    paintRecorder.register(paintMultiChildCommand);
  }

  @override
  void performLayout() {
    int width = 0;
    int height = 0;

    late final Constraints constraints;

    if(direction == Direction.horizontal) {
      constraints = Constraints(
          minWidth: 0,
          maxWidth: maxInt,
          minHeight: 0,
          maxHeight: this.constraints.maxHeight,
      );
    }else {
      constraints = Constraints(
          minWidth: 0,
          maxWidth: this.constraints.maxWidth,
          minHeight: 0,
          maxHeight: maxInt,
      );
    }

    int totalFlex = 0;
    final List<RenderFlexible> childRenderFlexibles = [];

    for(int i = 0; i < childrens.length; i++) {
      final RenderBox child = childrens[i] as RenderBox;

      if(child is RenderFlexible) {
        totalFlex += child.flex;
        childRenderFlexibles.add(child);
        continue;
      }

      child.layout(constraints);

      if(direction == Direction.horizontal) {
        width += child.size.width;
        height = max(height, child.size.height);
      }else {
        width = max(width, child.size.width);
        height += child.size.height;
      }
    }

    if(direction == Direction.horizontal) {
      width += spacing * (childrens.length - 1);
    }else {
      height += spacing * (childrens.length - 1);
    }

    if(childRenderFlexibles.isNotEmpty) {
      final int remainingWidth = this.constraints.maxWidth - width;
      final int remainingHeight = this.constraints.maxHeight - height;

      for(final RenderFlexible childRenderFlexible in childRenderFlexibles) {
        late final int childWidth;
        late final int childHeight;

        if(direction == Direction.horizontal) {
          childWidth = (remainingWidth / totalFlex * childRenderFlexible.flex).toInt();
          childHeight = height;
        }else {
          childWidth = width;
          childHeight = (remainingHeight / totalFlex * childRenderFlexible.flex).toInt();
        }

        width += childWidth;
        width += childHeight;
        childRenderFlexible.layout(Constraints(maxWidth: childWidth, maxHeight: childHeight));
      }
    }

    _childrensSize = Size(width: width, height: height);

    if(mainAxisSize == MainAxisSize.max) {
      if(direction == Direction.horizontal) {
        width = this.constraints.hasBoundedWidth ? this.constraints.maxWidth : width;
      }else {
        height = this.constraints.hasBoundedHeight ? this.constraints.maxHeight : height;
      }
    }

    size = Size(width: width, height: height);
  }

  @override
  Future<void> prepareLayout() async {
    final List<Future> futures = [];

    for(final RenderObject child in childrens) {
      futures.add(child.prepareLayout());
    }

    try {
      await Future.wait(futures);
    }catch(e) {
      print(e);
    }
  }

  @override
  bool get needsChildLayout => true;
}