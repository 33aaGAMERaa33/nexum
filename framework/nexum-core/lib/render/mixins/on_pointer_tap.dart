import 'package:nexum_core/events/pointer_click_event.dart';
import 'package:nexum_core/material/render_object.dart';

import '../../events/event.dart';

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