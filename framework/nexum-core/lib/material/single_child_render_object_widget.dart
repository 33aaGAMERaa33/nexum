import 'package:nexum_core/material/element.dart';
import 'package:nexum_core/material/leaf_child_render_object_element.dart';
import 'package:nexum_core/material/render_object_widget.dart';
import 'package:nexum_core/material/single_child_render_object_element.dart';
import 'package:nexum_core/material/widget.dart';

abstract class SingleChildRenderObjectWidget extends RenderObjectWidget {
  final Widget ? child;
  const SingleChildRenderObjectWidget({required this.child});

  @override
  Element createElement() => SingleChildRenderObjectElement(this);
}