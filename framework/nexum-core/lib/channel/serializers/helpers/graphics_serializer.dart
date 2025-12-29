import 'package:nexum_core/core/services/helper_serializer_service.dart';
import 'package:nexum_core/channel/friendly_buffer.dart';
import 'package:nexum_core/channel/helper_serializer.dart';
import 'package:nexum_core/render/graphics.dart';
import 'package:nexum_core/render/graphics_instruction.dart';

class GraphicsSerializer extends HelperSerializer<Graphics> {
  @override
  String get identifier => "graphics";

  @override
  Type get objectType => Graphics;

  @override
  void serialize(Graphics object, FriendlyBuffer friendlyBuffer) {
    for(final GraphicsInstruction graphicsInstruction in object.instructions) {
      HelperSerializerService.instance.serializeObject(graphicsInstruction, friendlyBuffer);
    }

    friendlyBuffer.writeInt(object.instructions.length);
  }
}