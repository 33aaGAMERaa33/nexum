import 'package:nexum_core/helpers/logger.dart';
import 'package:nexum_core/material/build_context.dart';
import 'package:nexum_core/material/render_object.dart';
import 'package:nexum_core/material/widget.dart';

abstract class Element extends BuildContext {
  Object ? slot;
  Element ? parent;
  bool mounted = false;
  RenderObject ? renderObject;

  Element(super.widget);

  void mount(Element ? parent, Object ? slot) {
    this.parent = parent;
    this.slot = slot;
    mounted = true;
  }

  void unmount() {
    parent = null;
    slot = null;
    mounted = false;

    renderObject?.dispose();
    renderObject = null;
  }

  void update(Widget newWidget) {
    widget = newWidget;
  }

  bool canUpdate(Widget newWidget) {
    final bool canUpdate = widget.runtimeType == newWidget.runtimeType && widget.key == newWidget.key;

    return canUpdate;
  }
}