import 'package:nexum_core/exceptions/incorrect_render_object_update.dart';
import 'package:nexum_core/material/alignament.dart';
import 'package:nexum_core/material/render_object.dart';
import 'package:nexum_core/material/single_child_render_object_widget.dart';

import '../render/renderers/render_align.dart';

class Align extends SingleChildRenderObjectWidget {
  final Alignment alignment;

  const Align({
    this.alignment = Alignment.topLeft,
    required super.child,
  });

  @override
  RenderObject createRenderObject() => RenderAlign(alignment);

  @override
  void updateRenderObject(RenderObject renderObject) {
    if(renderObject is! RenderAlign) throw IncorrectRenderObjectUpdate(renderObject, RenderAlign);

    renderObject.alignment = alignment;
    renderObject.update();
  }
}