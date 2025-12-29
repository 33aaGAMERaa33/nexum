import 'dart:async';
import 'dart:collection';

import 'package:nexum_core/channel/deserializers/heart_beat_deserializer.dart';
import 'package:nexum_core/channel/deserializers/start_nexum_packet_deserializer.dart';
import 'package:nexum_core/channel/handlers/heart_beat_packet_handler.dart';
import 'package:nexum_core/channel/serializers/heart_beat_packet_serializer.dart';
import 'package:nexum_core/channel/serializers/helpers/clip_rect_instruction_serializer.dart';
import 'package:nexum_core/channel/serializers/helpers/draw_rect_instruction_serializer.dart';
import 'package:nexum_core/channel/serializers/helpers/set_composite_instruction_serializer.dart';
import 'package:nexum_core/channel/serializers/helpers/size_serializer.dart';
import 'package:nexum_core/channel/serializers/ready_to_start_packet_serializer.dart';
import 'package:nexum_core/core/storages/helper_deserializer_registry.dart';
import 'package:nexum_core/core/storages/helper_serializer_registry.dart';
import 'package:nexum_core/core/storages/packet_deserializer_registry.dart';
import 'package:nexum_core/core/storages/packet_handler_registry.dart';
import 'package:nexum_core/core/storages/packet_serializer_registry.dart';
import 'package:nexum_core/exceptions/packet_handle_exception.dart';
import 'package:nexum_core/helpers/logger.dart';
import 'package:nexum_core/channel/deserializers/event_packet_deserializer.dart';
import 'package:nexum_core/channel/deserializers/helpers/offset_deserializer.dart';
import 'package:nexum_core/channel/deserializers/helpers/pointer_click_event_deserializer.dart';
import 'package:nexum_core/channel/deserializers/helpers/pointer_move_event_deserializer.dart';
import 'package:nexum_core/channel/deserializers/helpers/size_deserializer.dart';
import 'package:nexum_core/channel/deserializers/helpers/test_object_deserializer.dart';
import 'package:nexum_core/channel/deserializers/helpers/text_metrics_deserializer.dart';
import 'package:nexum_core/channel/deserializers/send_text_metrics_packet_deserializer.dart';
import 'package:nexum_core/channel/deserializers/sync_data_packet_deserializer.dart';
import 'package:nexum_core/channel/deserializers/test_packet_deserializer.dart';
import 'package:nexum_core/channel/friendly_buffer.dart';
import 'package:nexum_core/channel/handlers/event_packet_handler.dart';
import 'package:nexum_core/channel/handlers/test_packet_handler.dart';
import 'package:nexum_core/channel/channel.dart';
import 'package:nexum_core/channel/packet.dart';
import 'package:nexum_core/channel/serializers/helpers/color_serializer.dart';
import 'package:nexum_core/channel/serializers/helpers/create_graphics_instruction_serializer.dart';
import 'package:nexum_core/channel/serializers/helpers/font_serializer.dart';
import 'package:nexum_core/channel/serializers/helpers/draw_string_instruction_serializer.dart';
import 'package:nexum_core/channel/serializers/helpers/graphics_serializer.dart';
import 'package:nexum_core/channel/serializers/helpers/offset_serializer.dart';
import 'package:nexum_core/channel/serializers/helpers/set_color_instruction_serializer.dart';
import 'package:nexum_core/channel/serializers/helpers/set_font_instructon_serializer.dart';
import 'package:nexum_core/channel/serializers/helpers/test_object_serializer.dart';
import 'package:nexum_core/channel/serializers/helpers/translate_instruction_serializer.dart';
import 'package:nexum_core/channel/serializers/logger_packet_serializer.dart';
import 'package:nexum_core/channel/serializers/request_data_sync_packet_serializer.dart';
import 'package:nexum_core/channel/serializers/request_text_metrics_serializer.dart';
import 'package:nexum_core/channel/serializers/send_graphics_packet_serializer.dart';
import 'package:nexum_core/channel/serializers/test_packet_serializer.dart';

import '../core/services/packet_deserializer_service.dart';
import '../core/services/packet_handler_service.dart';
import '../core/services/packet_serializer_service.dart';

class PacketManager {
  static PacketManager ? _instance;
  static PacketManager get instance => _instance!;
  static bool get initialized => _instance != null;

  final HashMap<Type, List<_WaitingPacket>> _waitingsPacket = HashMap();
  final HashMap<String, _WaitingPacket> _waitingResponseHandlers = HashMap();

  PacketManager._() {
    HelperSerialzerRegistry.instance.register(DrawRectInstructionSerializer());
    HelperSerialzerRegistry.instance.register(ClipRectInstructionSerializer());
    HelperSerialzerRegistry.instance.register(SetCompositeInstructionSerializer());
    HelperSerialzerRegistry.instance.register(SizeSerializer());
    HelperSerialzerRegistry.instance.register(OffsetSerializer());
    HelperSerialzerRegistry.instance.register(TranslateInstructionSerializer());
    HelperSerialzerRegistry.instance.register(FontSerializer());
    HelperSerialzerRegistry.instance.register(ColorSerializer());
    HelperSerialzerRegistry.instance.register(TestObjectSerializer());
    HelperSerialzerRegistry.instance.register(GraphicsSerializer());
    HelperSerialzerRegistry.instance.register(CreateGraphicsInstructionSerializer());
    HelperSerialzerRegistry.instance.register(DrawStringInstructionSerializer());
    HelperSerialzerRegistry.instance.register(SetFontInstructonSerializer());
    HelperSerialzerRegistry.instance.register(SetColorInstructionSerializer());

    HelperDeserializerRegistry.instance.register(OffsetDeserializer());
    HelperDeserializerRegistry.instance.register(PointerClickEventDeserializer());
    HelperDeserializerRegistry.instance.register(PointerMoveEventDeserializer());
    HelperDeserializerRegistry.instance.register(TestObjectDeserializer());
    HelperDeserializerRegistry.instance.register(SizeDeserializer());
    HelperDeserializerRegistry.instance.register(TextMetricsDeserializer());

    PacketHandlerRegistry.instance.register(TestPacketHandler());
    PacketHandlerRegistry.instance.register(HeartBeatPacketHandler());
    PacketHandlerRegistry.instance.register(EventPacketHandler());

    PacketSerializerRegistry.instance.register(LoggerPacketSerializer());
    PacketSerializerRegistry.instance.register(HeartBeatPacketSerializer());
    PacketSerializerRegistry.instance.register(ReadyToStartPacketSerializer());
    PacketSerializerRegistry.instance.register(TestPacketSerializer());
    PacketSerializerRegistry.instance.register(SendGraphicsPacketSerializer());
    PacketSerializerRegistry.instance.register(RequestDataSyncPacketSerializer());
    PacketSerializerRegistry.instance.register(RequestTextMetricsSerializer());

    PacketDeserializerRegistry.instance.register(EventPacketDeserializer());
    PacketDeserializerRegistry.instance.register(HeartBeatDeserializer());
    PacketDeserializerRegistry.instance.register(StartNexumPacketDeserializer());
    PacketDeserializerRegistry.instance.register(TestPacketDeserializer());
    PacketDeserializerRegistry.instance.register(SyncDataPacketDeserializer());
    PacketDeserializerRegistry.instance.register(SendTextMetricsPacketDeserializer());
  }

  static PacketManager initialize() => _instance = PacketManager._();

  void handleReceivedData(String data) {
    final FriendlyBuffer friendlyBuffer = FriendlyBuffer.fromData(data);

    try {
      final Packet packetDeserialized = PacketDeserializerService.deserializePacket(friendlyBuffer);
      final _WaitingPacket ? waitingResponse = _waitingResponseHandlers.remove(packetDeserialized.uuid!);
      final List<_WaitingPacket> ? waitingPacket = _waitingsPacket[packetDeserialized.runtimeType];

      if(waitingResponse != null) {
        waitingResponse.callback(packetDeserialized);
        return;
      }

      try {
        PacketHandlerService.handlePacket(packetDeserialized);
      }on Exception catch(e, stack) {
        if(e is PacketHandleException) {
          if(waitingPacket != null) {
            return;
          }

          _warn(e.toString());
        }else {
          _error(stack.toString());
          _error(e.toString());
        }
      }
    }catch(e, stack) {
      _error(stack.toString());
      _error(e.toString());
    }
  }

  void sendPacket<T extends Packet>(T packet) {
    packet.uuid ??= Packet.uuidFactory.v4();

    final Channel channel = Channel.instance;
    final FriendlyBuffer packetSerialized = PacketSerializerService.instance.serializePacket(packet);

    channel.send(packetSerialized.buildData());
  }

  void sendResponsePacket<T extends Packet, R extends Packet>({
    required T requestPacket,
    required R responsePacket
  }) {
    if(requestPacket.uuid == null) {
      _warn("Não é possivel enviar um pacote de resposta para o pacote $T pois o UUID não foi encontrado");
      return;
    }else if(responsePacket.uuid != null) {
      _warn("Não é possivel enviar o pacote de resposta pois ele já possui UUID");
      return;
    }

    responsePacket.uuid = requestPacket.uuid!;
    sendPacket(responsePacket);
  }

  Future<T?> waitPacket<T extends Packet>([Duration timeout = const Duration(milliseconds: 1000)]) {
    bool waiting = true;
    final completer = Completer<T?>();
    final List<_WaitingPacket> waitingPacket = _waitingsPacket[T] ?? [];

    Future.delayed(timeout, () {
      if(!waiting) return;
      waiting = false;
      completer.complete(null);
    });

    waitingPacket.add(_WaitingPacket(DateTime.now().millisecondsSinceEpoch, (packet) {
      if(!waiting) return;
      waiting = false;
      completer.complete(packet);
    }));

    _waitingsPacket[T] = waitingPacket;
    return completer.future;
  }

  Future<R> sendPacketAndWaitResponse<T extends Packet, R extends Packet>(T packet) {
    final Completer<R> completer = Completer();

    sendPacketAndWaitResponseWithFunction(
      packet: packet, onResponse: completer.complete,
    );

    return completer.future;
  }

  void sendPacketAndWaitResponseWithFunction<T extends Packet, R extends Packet>({
    required T packet,
    required Function(R) onResponse
  }) {
    sendPacket<T>(packet);
    _waitingResponseHandlers[packet.uuid!] = _WaitingPacket(DateTime.now().millisecondsSinceEpoch, onResponse);
  }

  void _debug(String log) {
    Logger.debug("PacketManager", log);
  }

  void _warn(String log) {
    Logger.warn("PacketManager", log);
  }

  void _error(String log) {
    Logger.error("PacketManager", log);
  }
}

class _WaitingPacket {
  final Function callback;
  final int startTime; // millisecondsSinceEpoch

  _WaitingPacket(this.startTime, this.callback);
}
