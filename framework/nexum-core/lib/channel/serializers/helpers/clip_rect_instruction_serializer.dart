import 'package:nexum_core/channel/friendly_buffer.dart';
import 'package:nexum_core/channel/helper_serializer.dart';
import 'package:nexum_core/core/services/helper_serializer_service.dart';
import 'package:nexum_core/render/instructions/clip_rect_instruction.dart';

class ClipRectInstructionSerializer extends HelperSerializer<ClipRectInstruction> {
  @override
  void serialize(ClipRectInstruction object, FriendlyBuffer friendlyBuffer) {
    HelperSerializerService.instance.serializeObject(object.size, friendlyBuffer);
    HelperSerializerService.instance.serializeObject(object.offset, friendlyBuffer);
  }

  @override
  String get identifier => "clip_rect";

  @override
  Type get objectType => ClipRectInstruction;
}