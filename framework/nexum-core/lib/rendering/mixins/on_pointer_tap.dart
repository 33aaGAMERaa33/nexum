
import '../../foundation/events/event.dart';
import '../../foundation/events/pointer_events.dart';
import '../object.dart';

mixin OnPointerTap on RenderObject {
  @override
  void propagateEvent<T extends Event>(T event) {
    super.propagateEvent(event);

    if(event is PointerClickEvent && hitTest(event.position) && !event.released) {
      onTap();
    }
  }

  void onTap();
}