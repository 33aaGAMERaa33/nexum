import 'package:nexum_core/material/component_element.dart';
import 'package:nexum_core/material/state.dart';
import 'package:nexum_core/material/stateful_widget.dart';
import 'package:nexum_core/material/widget.dart';

import 'element.dart';

class StatefulElement extends ComponentElement {
  State ? _state;

  StatefulElement(StatefulWidget super.widget) : _state = widget.createState() {
    _state!.attach(widget, this);
  }

  @override
  Widget build() => _state!.build(this);

  @override
  void mount(Element? parent, Object? slot) {
    _state!.initState();
    super.mount(parent, slot);
  }

  @override
  void unmount() {
    _state?.dispose();
    _state = null;
    super.unmount();
  }

  @override
  void update(Widget newWidget) {
    super.update(newWidget);
    assert(widget == newWidget);
    _state!.attach(widget, this);
    rebuild(force: true);
  }

  @override
  StatefulWidget get widget => super.widget as StatefulWidget;
}