import 'package:nexum_core/exceptions/incorrect_render_object_update.dart';
import 'package:nexum_core/material/render_object.dart';
import 'package:nexum_core/material/single_child_render_object_widget.dart';

import '../render/renderers/render_constrained_box.dart';

class SizedBox extends SingleChildRenderObjectWidget {
  final int ? width;
  final int ? height;

  const SizedBox({
    super.child,
    this.width,
    this.height,
  });

  @override
  RenderObject createRenderObject() => RenderConstrainedBox(width: width, height: height);

  @override
  void updateRenderObject(RenderObject renderObject) {
    if(renderObject is! RenderConstrainedBox) throw IncorrectRenderObjectUpdate(renderObject, RenderConstrainedBox);

    renderObject.width = width;
    renderObject.height = height;
    renderObject.update();
  }
}