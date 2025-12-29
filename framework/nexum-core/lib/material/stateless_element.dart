import 'package:nexum_core/material/component_element.dart';
import 'package:nexum_core/material/stateless_widget.dart';
import 'package:nexum_core/material/widget.dart';

class StatelessElement extends ComponentElement {
  StatelessElement(StatelessWidget super.widget);

  @override
  Widget build() => widget.build(this);

  @override
  StatelessWidget get widget => super.widget as StatelessWidget;
}