import 'package:nexum_core/channel/friendly_buffer.dart';
import 'package:nexum_core/channel/packet_serializer.dart';
import 'package:nexum_core/channel/packets/request_data_sync_packet.dart';

class RequestDataSyncPacketSerializer extends PacketSerializer<RequestDataSyncPacket> {
  @override
  String get identifier => "request_data_sync";

  @override
  Type get packetType => RequestDataSyncPacket;

  @override
  void serialize(RequestDataSyncPacket packet, FriendlyBuffer friendlyBuffer) {

  }
}