import 'package:nexum_core/channel/friendly_buffer.dart';
import 'package:nexum_core/channel/helper_serializer.dart';
import 'package:nexum_core/render/instructions/draw_string_instruction.dart';

class DrawStringInstructionSerializer extends HelperSerializer<DrawStringInstruction> {
  @override
  String get identifier => "draw_string";

  @override
  Type get objectType => DrawStringInstruction;

  @override
  void serialize(DrawStringInstruction object, FriendlyBuffer friendlyBuffer) {
    friendlyBuffer.writeString(object.string);
  }
}