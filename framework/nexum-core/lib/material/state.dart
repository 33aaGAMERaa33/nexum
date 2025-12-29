import 'package:nexum_core/material/build_context.dart';
import 'package:nexum_core/material/stateful_element.dart';
import 'package:nexum_core/material/stateful_widget.dart';
import 'package:nexum_core/material/widget.dart';
import 'package:nexum_core/types/void_callback.dart';

abstract class State<T extends StatefulWidget> {
  T ? _widget;
  T get widget => _widget!;

  StatefulElement ? _element;
  StatefulElement get element => _element!;

  Widget build(BuildContext context);

  void setState(VoidCallback update) {
    update.call();
    element.markNeedsBuild();
  }

  void initState() {

  }

  void dispose() {
    _widget = null;
    _element = null;
  }

  void attach(T widget, StatefulElement element) {
    _widget = widget;
    _element = element;
  }
}