import 'package:nexum_core/core/services/helper_serializer_service.dart';
import 'package:nexum_core/channel/friendly_buffer.dart';
import 'package:nexum_core/channel/helper_serializer.dart';
import 'package:nexum_core/render/instructions/set_color_instruction.dart';

class SetColorInstructionSerializer extends HelperSerializer<SetColorInstruction> {
  @override
  String get identifier => "set_color";

  @override
  Type get objectType => SetColorInstruction;

  @override
  void serialize(SetColorInstruction object, FriendlyBuffer friendlyBuffer) {
    HelperSerializerService.instance.serializeObject(object.color, friendlyBuffer);
  }
}