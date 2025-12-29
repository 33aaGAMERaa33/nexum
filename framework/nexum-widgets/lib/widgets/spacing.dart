import 'expanded.dart';
import 'sized_box.dart';

class Spacing extends Expanded {
  const Spacing({super.flex = 1}) : super(child: const SizedBox());
}