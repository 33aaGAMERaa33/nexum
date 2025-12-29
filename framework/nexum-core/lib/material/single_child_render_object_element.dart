import 'package:nexum_core/material/element.dart';
import 'package:nexum_core/material/render_object.dart';
import 'package:nexum_core/material/render_object_element.dart';
import 'package:nexum_core/material/single_child_render_object_widget.dart';
import 'package:nexum_core/material/widget.dart';

class SingleChildRenderObjectElement extends RenderObjectElement {
  Element ? _child;
  SingleChildRenderObjectElement(SingleChildRenderObjectWidget super.widget);

  @override
  void mount(Element? parent, Object? slot) {
    super.mount(parent, slot);
    final Element ? child = widget.child?.createElement();

    if(child != null) {
      child.mount(this, null);
      assert(renderObject != null);

      final RenderObject ? childRenderObject = child.renderObject;

      if(childRenderObject != null) {
        renderObject!.adoptChild(childRenderObject);
      }
    }

    _child = child;
  }

  @override
  void unmount() {
    _child?.renderObject?.dispose();
    _child?.unmount();
    _child = null;
    super.unmount();
  }

  @override
  void update(Widget newWidget) {
    super.update(newWidget);
    assert(renderObject != null);

    final Element ? oldChild = _child;
    final Widget ? newChildWidget = widget.child;

    if(oldChild != null && newChildWidget != null && oldChild.canUpdate(newChildWidget)) {
      oldChild.update(newChildWidget);
      return;
    }

    if(newChildWidget == null) {
      if(oldChild != null) {
        final RenderObject ? oldChildRenderObject = oldChild.renderObject;

        if(oldChildRenderObject != null) {
          renderObject!.dropChild(oldChildRenderObject);
        }

        oldChild.unmount();
      }

      _child = null;
      return;
    }

    if(oldChild != null) {
      final RenderObject ? oldChildRenderObject = oldChild.renderObject;
      
      if(oldChildRenderObject != null) {
        renderObject!.dropChild(oldChildRenderObject);
      }

      oldChild.unmount();
    }

    final Element newChild = _child = newChildWidget.createElement();
    newChild.mount(this, null);

    final RenderObject ? newChildRenderObject = newChild.renderObject;

    if(newChildRenderObject != null) {
      renderObject!.adoptChild(newChildRenderObject);
    }
  }

  @override
  SingleChildRenderObjectWidget get widget => super.widget as SingleChildRenderObjectWidget;
}