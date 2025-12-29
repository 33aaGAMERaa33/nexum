import 'package:nexum_core/material/direction.dart';
import 'package:nexum_core/material/main_axis_alignment.dart';
import 'package:nexum_core/material/main_axis_size.dart';

import 'flex.dart';

class Column extends Flex {
  const Column({
    super.spacing = 0,
    required super.childrens,
    super.mainAxisSize = MainAxisSize.max,
    super.mainAxisAlignment = MainAxisAlignment.start,
  }) : super(direction: Direction.vertical);
}