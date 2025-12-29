import 'package:nexum_core/material/build_context.dart';
import 'package:nexum_core/material/element.dart';
import 'package:nexum_core/material/stateless_element.dart';
import 'package:nexum_core/material/widget.dart';

abstract class StatelessWidget extends Widget {
  const StatelessWidget({super.key});
  Widget build(BuildContext context);

  @override
  Element createElement() => StatelessElement(this);
}