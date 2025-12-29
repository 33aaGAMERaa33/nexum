import 'package:nexum_core/events/pointer_event.dart';

class PointerClickEvent extends PointerEvent {
  final bool released;
  PointerClickEvent(super.position, this.released);
}