import 'package:nexum_core/core/services/helper_serializer_service.dart';
import 'package:nexum_core/channel/friendly_buffer.dart';
import 'package:nexum_core/channel/helper_serializer.dart';
import 'package:nexum_core/render/instructions/create_sub_context_instruction.dart';

class CreateSubContextInstructionSerializer extends HelperSerializer<CreateSubContextInstruction>{
  @override
  String get identifier => "create_sub_context";

  @override
  Type get objectType => CreateSubContextInstruction;

  @override
  void serialize(CreateSubContextInstruction object, FriendlyBuffer friendlyBuffer) {
    HelperSerializerService.instance.serializeObject(object.renderContext, friendlyBuffer);
  }
}