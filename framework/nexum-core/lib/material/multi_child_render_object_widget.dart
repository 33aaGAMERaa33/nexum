import 'package:nexum_core/material/element.dart';
import 'package:nexum_core/material/multi_child_render_object_element.dart';
import 'package:nexum_core/material/render_object_widget.dart';
import 'package:nexum_core/material/widget.dart';

abstract class MultiChildRenderObjectWidget extends RenderObjectWidget {
  final List<Widget> childrens;
  const MultiChildRenderObjectWidget(this.childrens);

  @override
  Element createElement() => MultiChildRenderObjectElement(this);
}