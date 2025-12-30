import '../../../rendering/rendering.dart';
import '../../../services/helper_serializer_service.dart';
import '../friendly_buffer.dart';
import '../helper_serializer.dart';
import '../packet_serializer.dart';
import '../packets/rendering.dart';

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

class ClipRectInstructionSerializer extends HelperSerializer<ClipRectInstruction> {
  @override
  void serialize(ClipRectInstruction object, FriendlyBuffer friendlyBuffer) {
    HelperSerializerService.instance.serializeObject(object.size, friendlyBuffer);
    HelperSerializerService.instance.serializeObject(object.offset, friendlyBuffer);
  }

  @override
  String get identifier => "clip_rect";

  @override
  Type get objectType => ClipRectInstruction;
}

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

class CreateNewContextInstructionSerializer extends HelperSerializer<CreateNewContextInstruction> {
  @override
  void serialize(CreateNewContextInstruction object, FriendlyBuffer friendlyBuffer) {
    HelperSerializerService.instance.serializeObject(object.renderContext, friendlyBuffer);
  }

  @override
  String get identifier => "create_new_context";

  @override
  Type get objectType => CreateNewContextInstruction;
}

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

class SendRenderContextPacketSerializer extends PacketSerializer<SendRenderContextPacket>{
  @override
  String get identifier => "send_render_context";

  @override
  Type get packetType => SendRenderContextPacket;

  @override
  void serialize(SendRenderContextPacket packet, FriendlyBuffer friendlyBuffer) {
    HelperSerializerService.instance.serializeObject(packet.renderContext, friendlyBuffer);
  }
}