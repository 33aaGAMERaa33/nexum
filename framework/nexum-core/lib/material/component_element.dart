import 'package:nexum_core/core/nexum.dart';
import 'package:nexum_core/material/element.dart';
import 'package:nexum_core/material/render_object.dart';
import 'package:nexum_core/material/widget.dart';

import '../helpers/logger.dart';

abstract class ComponentElement extends Element {
  Element ? _child;
  bool _dirty = true;
  bool get dirty => _dirty;

  ComponentElement(super.widget);

  Widget build();

  @override
  void mount(Element? parent, Object? slot) {
    super.mount(parent, slot);
    final Element child = build().createElement();
    child.mount(this, null);

    _child = child;
    _dirty = false;
  }

  @override
  void unmount() {
    _child?.unmount();
    _child = null;
    super.unmount();
  }

  @override
  void update(Widget newWidget) {
    super.update(newWidget);
    rebuild(force: true);
  }

  Element _updateChild(Element ? oldChild, Widget newChildWidget) {
    final RenderObject ? parentRenderObject = parent?.renderObject;
    assert(parentRenderObject != null);

    if(oldChild != null && oldChild.canUpdate(newChildWidget)) {
      oldChild.update(newChildWidget);
      return oldChild;
    }

    if(oldChild != null) {
      if(parentRenderObject != null && oldChild.renderObject != null) {
        parentRenderObject.dropChild(oldChild.renderObject!);
      }

      oldChild.unmount();
    }

    final Element newChild = newChildWidget.createElement();
    newChild.mount(this, null);

    if(parentRenderObject != null && newChild.renderObject != null) {
      parentRenderObject.adoptChild(newChild.renderObject!);
      parentRenderObject.update();
    }

    return newChild;
  }

  void markNeedsBuild() {
    if(_dirty) return;
    _dirty = true;
    Nexum.instance.scheduleBuildFor(this);
  }

  void rebuild({bool force = false}) {
    if(!_dirty && !force) return;
    _dirty = false;
    _child = _updateChild(_child, build());
  }

  @override
  RenderObject? get renderObject => _child?.renderObject;
}