import 'package:nexum_core/material/render_object.dart';
import 'package:nexum_core/material/widget.dart';

abstract class RenderObjectWidget extends Widget {
  const RenderObjectWidget();
  RenderObject createRenderObject();
  void updateRenderObject(RenderObject renderObject);
}