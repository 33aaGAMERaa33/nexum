import 'package:nexum_core/core/services/helper_deserializer_service.dart';
import 'package:nexum_core/events/event.dart';
import 'package:nexum_core/channel/friendly_buffer.dart';
import 'package:nexum_core/channel/packet_deserializer.dart';
import 'package:nexum_core/channel/packets/event_packet.dart';

class EventPacketDeserializer extends PacketDeserializer<EventPacket> {
  @override
  EventPacket deserialize(FriendlyBuffer friendlyBuffer) {
    final Event event = HelperDeserializerService.instance.deserializeObject(friendlyBuffer);
    return EventPacket(event);
  }

  @override
  String get identifier => "event";

  @override
  Type get packetType => EventPacket;
}