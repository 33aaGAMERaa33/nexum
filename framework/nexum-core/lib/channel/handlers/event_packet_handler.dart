import 'package:nexum_core/core/nexum.dart';
import 'package:nexum_core/channel/packet_handler.dart';
import 'package:nexum_core/channel/packets/event_packet.dart';

class EventPacketHandler extends PacketHandler<EventPacket> {
  @override
  void handle(EventPacket packet) {
    if(!Nexum.initialized) return;
    Nexum.instance.propagateEvent(packet.event);

    //Logger.log("EventPacketHandler", "Test");
  }

  @override
  Type get packetType => EventPacket;
}