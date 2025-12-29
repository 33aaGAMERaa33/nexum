import 'package:nexum_core/exceptions/incorrect_render_object_update.dart';
import 'package:nexum_core/material/render_object.dart';
import 'package:nexum_core/material/single_child_render_object_widget.dart';
import 'package:nexum_core/types/void_callback.dart';

import '../render/renderers/render_gesture_detector.dart';

class GestureDetector extends SingleChildRenderObjectWidget {
  final VoidCallback onTap;
  GestureDetector({
    required this.onTap,
    required super.child,
  });

  @override
  RenderObject createRenderObject() => RenderGestureDetector(onTap);

  @override
  void updateRenderObject(RenderObject renderObject) {
    if(renderObject is! RenderGestureDetector) throw IncorrectRenderObjectUpdate(renderObject, RenderGestureDetector);

    renderObject.onTapCallback = onTap;
    renderObject.update();
  }
}