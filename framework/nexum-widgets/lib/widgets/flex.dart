import 'package:nexum_core/material/direction.dart';
import 'package:nexum_core/material/main_axis_alignment.dart';
import 'package:nexum_core/material/main_axis_size.dart';
import 'package:nexum_core/material/multi_child_render_object_widget.dart';
import 'package:nexum_core/material/render_object.dart';
import 'package:nexum_core/material/widget.dart';
import 'package:nexum_core/exceptions/incorrect_render_object_update.dart';

import '../render/renderers/render_flex.dart';

class Flex extends MultiChildRenderObjectWidget {
  final int spacing;
  final Direction direction;
  final MainAxisSize mainAxisSize;
  final MainAxisAlignment mainAxisAlignment;

  const Flex({
    this.spacing = 0,
    required this.direction,
    this.mainAxisSize = MainAxisSize.max,
    this.mainAxisAlignment = MainAxisAlignment.start,
    required List<Widget> childrens,
  }) : super(childrens);

  @override
  RenderObject createRenderObject() => RenderFlex(
    spacing: spacing,
    direction: direction,
    mainAxisSize: mainAxisSize,
    mainAxisAlignment: mainAxisAlignment,
  );

  @override
  void updateRenderObject(RenderObject renderObject) {
    if(renderObject is! RenderFlex) throw IncorrectRenderObjectUpdate(renderObject, RenderFlex);

    renderObject.spacing = spacing;
    renderObject.direction = direction;
    renderObject.mainAxisSize = mainAxisSize;
    renderObject.mainAxisAlignment = mainAxisAlignment;

    renderObject.update();
  }
}