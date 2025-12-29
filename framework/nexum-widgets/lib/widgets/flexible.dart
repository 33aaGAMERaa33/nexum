import 'package:nexum_core/exceptions/incorrect_render_object_update.dart';
import 'package:nexum_core/material/flex_fit.dart';
import 'package:nexum_core/material/render_object.dart';
import 'package:nexum_core/material/single_child_render_object_widget.dart';

import '../render/renderers/render_flexible.dart';

class Flexible extends SingleChildRenderObjectWidget {
  final int flex;
  final FlexFit flexFit;

  const Flexible({
    this.flex = 1,
    this.flexFit = FlexFit.loose,
    required super.child,
  });

  @override
  RenderObject createRenderObject() => RenderFlexible(flex: flex, flexFit: flexFit);

  @override
  void updateRenderObject(RenderObject renderObject) {
    if(renderObject is! RenderFlexible) throw IncorrectRenderObjectUpdate(renderObject, RenderFlexible);

    renderObject.flex = flex;
    renderObject.flexFit = flexFit;
    renderObject.update();
  }
}