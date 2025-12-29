import 'package:nexum_core/material/render_object.dart';
import 'package:nexum_core/material/single_child_render_object_widget.dart';
import 'package:nexum_widgets/render/renderers/render_debug_box.dart';

class DebugBox extends SingleChildRenderObjectWidget {
  DebugBox({required super.child});

  @override
  RenderObject createRenderObject() => RenderDebugBox();

  @override
  void updateRenderObject(RenderObject renderObject) {

  }
}