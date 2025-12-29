import 'package:nexum_core/core/services/helper_serializer_service.dart';
import 'package:nexum_core/channel/friendly_buffer.dart';
import 'package:nexum_core/channel/helper_serializer.dart';
import 'package:nexum_core/render/instructions/create_graphics_instruction.dart';

class CreateGraphicsInstructionSerializer extends HelperSerializer<CreateGraphicsInstruction>{
  @override
  String get identifier => "create_graphics";

  @override
  Type get objectType => CreateGraphicsInstruction;

  @override
  void serialize(CreateGraphicsInstruction object, FriendlyBuffer friendlyBuffer) {
    HelperSerializerService.instance.serializeObject(object.graphics, friendlyBuffer);
  }
}