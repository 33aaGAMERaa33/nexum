import 'package:nexum_core/events/event.dart';
import 'package:nexum_core/channel/packet.dart';

class EventPacket extends Packet{
  final Event event;
  EventPacket(this.event);
}