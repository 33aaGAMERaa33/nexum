import 'package:nexum_core/material/element.dart';
import 'package:nexum_core/material/state.dart';
import 'package:nexum_core/material/stateful_element.dart';
import 'package:nexum_core/material/widget.dart';

abstract class StatefulWidget extends Widget {
  const StatefulWidget({super.key});
  State createState();

  @override
  Element createElement() => StatefulElement(this);
}