import 'package:nexum_core/material/render_object.dart';
import 'package:nexum_core/material/single_child_render_object_widget.dart';

import '../render/renderers/render_view.dart';

class View extends SingleChildRenderObjectWidget {
  View({required super.child});

  @override
  RenderObject createRenderObject() => RenderView();

  @override
  void updateRenderObject(RenderObject renderObject) {
    assert(renderObject is View);
    renderObject.update();
  }
}