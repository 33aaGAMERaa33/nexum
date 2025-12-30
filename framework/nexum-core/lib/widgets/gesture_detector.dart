import 'package:nexum_core/exceptions/incorrect_render_object_update.dart';

import '../foundation/types/void_callback.dart';
import '../rendering/object.dart';
import '../rendering/renderers/render_gesture_detector.dart';
import 'framework.dart';

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