import '../../painting/geometry.dart';
import 'event.dart';

abstract class PointerEvent extends Event {
  final Offset position;
  PointerEvent(this.position);
}

class PointerClickEvent extends PointerEvent {
  final bool released;
  PointerClickEvent(super.position, this.released);
}

class PointerMoveEvent extends PointerEvent {
  PointerMoveEvent(super.position);
}

class PointerScrollEvent extends PointerEvent {
  final int scrollModifier;
  final int scrollAmount;

  PointerScrollEvent({
    required this.scrollModifier,
    required this.scrollAmount,
    required Offset position,
  }) : super(position);
}