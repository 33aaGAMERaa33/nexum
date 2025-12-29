import 'package:nexum_core/material/element.dart';
import 'package:nexum_core/material/render_object_widget.dart';
import 'package:nexum_core/material/widget.dart';

abstract class RenderObjectElement extends Element {
  RenderObjectElement(RenderObjectWidget super.widget);

  @override
  void mount(Element? parent, Object? slot) {
    super.mount(parent, slot);

    renderObject = widget.createRenderObject();
    renderObject!.attach(this);
  }

  @override
  void unmount() {
    renderObject = null;
    super.unmount();
  }

  @override
  void update(Widget newWidget) {
    super.update(newWidget);
    assert(widget == newWidget);
    assert(renderObject != null);
    widget.updateRenderObject(renderObject!);
  }

  @override
  RenderObjectWidget get widget => super.widget as RenderObjectWidget;
}