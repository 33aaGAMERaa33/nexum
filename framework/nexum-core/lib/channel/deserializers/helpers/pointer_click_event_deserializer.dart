import 'package:nexum_core/core/services/helper_deserializer_service.dart';
import 'package:nexum_core/events/pointer_click_event.dart';
import 'package:nexum_core/models/offset.dart';
import 'package:nexum_core/channel/friendly_buffer.dart';
import 'package:nexum_core/channel/helper_deserializer.dart';

class PointerClickEventDeserializer extends HelperDeserializer<PointerClickEvent> {
  @override
  PointerClickEvent deserialize(FriendlyBuffer friendlyBuffer) {
    final bool released = friendlyBuffer.readBoolean();
    final Offset position = HelperDeserializerService.instance.deserializeObject(friendlyBuffer);

    return PointerClickEvent(position, released);
  }

  @override
  String get identifier => "pointer_click";

  @override
  Type get objectType => PointerClickEvent;
}