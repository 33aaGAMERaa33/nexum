import 'package:nexum_core/material/element.dart';
import 'package:nexum_core/material/leaf_child_render_object_element.dart';
import 'package:nexum_core/material/render_object_widget.dart';

abstract class LeafChildRenderObjectWidget extends RenderObjectWidget {
  const LeafChildRenderObjectWidget();

  @override
  Element createElement() => LeafChildRenderObjectElement(this);
}