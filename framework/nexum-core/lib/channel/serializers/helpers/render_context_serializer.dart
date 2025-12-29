import 'package:nexum_core/core/services/helper_serializer_service.dart';
import 'package:nexum_core/channel/friendly_buffer.dart';
import 'package:nexum_core/channel/helper_serializer.dart';
import 'package:nexum_core/render/render_context.dart';
import 'package:nexum_core/render/render_instruction.dart';

class RenderContextSerializer extends HelperSerializer<RenderContext> {
  @override
  String get identifier => "graphics";

  @override
  Type get objectType => RenderContext;

  @override
  void serialize(RenderContext object, FriendlyBuffer friendlyBuffer) {
    for(final RenderInstruction renderInstruction in object.instructions) {
      HelperSerializerService.instance.serializeObject(renderInstruction, friendlyBuffer);
    }

    friendlyBuffer.writeInt(object.instructions.length);
  }
}