import 'package:nexum_core/channel/friendly_buffer.dart';
import 'package:nexum_core/channel/helper_serializer.dart';
import 'package:nexum_core/core/services/helper_serializer_service.dart';
import 'package:nexum_core/render/instructions/draw_rect_instruction.dart';

class DrawRectInstructionSerializer extends HelperSerializer<DrawRectInstruction> {
  @override
  void serialize(DrawRectInstruction object, FriendlyBuffer friendlyBuffer) {
    HelperSerializerService.instance.serializeObject(object.size, friendlyBuffer);
  }

  @override
  String get identifier => "draw_rect";

  @override
  Type get objectType => DrawRectInstruction;
}