import 'package:nexum_core/helpers/logger.dart';
import 'package:nexum_core/models/offset.dart';
import 'package:nexum_core/models/size.dart';

class Rect {
  final Offset start;
  late final Offset end;
  late final Size size;

  Rect({required this.start, required this.end}) {
    assert(start.isBefore(end));
    size = Size(width: end.leftPos - start.leftPos, height: end.topPos - start.topPos);
  }

  Rect.fromSize({required this.start, required this.size}) {
    end = Offset(leftPos: start.leftPos + size.width, topPos: start.topPos + size.height);
    assert(start.isBefore(end), "$start -> $end");
  }

  bool contains(Offset offset) => start.isBefore(offset) && end.isAfter(offset);

  @override
  String toString() => "Rect(start: $start, end: $end, size: $size)";
}