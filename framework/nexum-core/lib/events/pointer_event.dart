import 'package:nexum_core/events/event.dart';
import 'package:nexum_core/models/offset.dart';

abstract class PointerEvent extends Event {
  final Offset position;
  PointerEvent(this.position);
}