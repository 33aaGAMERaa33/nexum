import 'package:nexum_core/exceptions/incorrect_render_object_update.dart';
import 'package:nexum_core/material/edge_insets.dart';
import 'package:nexum_core/material/render_object.dart';
import 'package:nexum_core/material/single_child_render_object_widget.dart';

import '../render/renderers/render_padding.dart';

class Padding extends SingleChildRenderObjectWidget {
  final EdgeInsets edgeInsets;

  const Padding({
    required this.edgeInsets,
    required super.child,
  });

  @override
  RenderObject createRenderObject() => RenderPadding(edgeInsets);

  @override
  void updateRenderObject(RenderObject renderObject) {
    if(renderObject is! RenderPadding) throw IncorrectRenderObjectUpdate(renderObject, RenderPadding);

    renderObject.edgeInsets = edgeInsets;
    renderObject.update();
  }
}