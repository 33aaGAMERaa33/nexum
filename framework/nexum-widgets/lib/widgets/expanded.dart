import 'package:nexum_core/material/flex_fit.dart';

import 'flexible.dart';

class Expanded extends Flexible {
  const Expanded({
    super.flex = 1,
    required super.child,
  }) : super(flexFit: FlexFit.tight);
}