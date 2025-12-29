import 'package:nexum_core/core/services/helper_serializer_service.dart';
import 'package:nexum_core/channel/friendly_buffer.dart';
import 'package:nexum_core/channel/helper_serializer.dart';
import 'package:nexum_core/render/instructions/translate_instruction.dart';

class TranslateInstructionSerializer extends HelperSerializer<TranslateInstruction> {
  @override
  String get identifier => "translate";

  @override
  Type get objectType => TranslateInstruction;

  @override
  void serialize(TranslateInstruction object, FriendlyBuffer friendlyBuffer) {
    HelperSerializerService.instance.serializeObject(object.offset, friendlyBuffer);
  }
}