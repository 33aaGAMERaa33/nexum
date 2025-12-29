import 'package:nexum_core/core/services/helper_serializer_service.dart';
import 'package:nexum_core/channel/friendly_buffer.dart';
import 'package:nexum_core/channel/helper_serializer.dart';
import 'package:nexum_core/render/instructions/set_font_instruction.dart';

class SetFontInstructonSerializer extends HelperSerializer<SetFontInstruction> {
  @override
  String get identifier => "set_font";

  @override
  Type get objectType => SetFontInstruction;

  @override
  void serialize(SetFontInstruction object, FriendlyBuffer friendlyBuffer) {
    HelperSerializerService.instance.serializeObject(object.font, friendlyBuffer);
  }
}