import 'package:nexum_core/core/services/helper_deserializer_service.dart';
import 'package:nexum_core/events/pointer_move_event.dart';
import 'package:nexum_core/models/offset.dart';
import 'package:nexum_core/channel/friendly_buffer.dart';
import 'package:nexum_core/channel/helper_deserializer.dart';

class PointerMoveEventDeserializer extends HelperDeserializer<PointerMoveEvent> {
  @override
  PointerMoveEvent deserialize(FriendlyBuffer friendlyBuffer) {
    final Offset position = HelperDeserializerService.instance.deserializeObject(friendlyBuffer);
    return PointerMoveEvent(position);
  }

  @override
  String get identifier => "pointer_move";

  @override
  Type get objectType => PointerMoveEvent;
}