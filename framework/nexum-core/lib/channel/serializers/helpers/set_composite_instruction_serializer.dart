import 'package:nexum_core/channel/friendly_buffer.dart';
import 'package:nexum_core/channel/helper_serializer.dart';
import 'package:nexum_core/render/instructions/set_composite_instruction.dart';

class SetCompositeInstructionSerializer extends HelperSerializer<SetCompositeInstruction> {
  @override
  void serialize(SetCompositeInstruction object, FriendlyBuffer friendlyBuffer) {
    friendlyBuffer.writeFloat(object.alpha);
  }

  @override
  String get identifier => "set_composite";

  @override
  Type get objectType => SetCompositeInstruction;
}