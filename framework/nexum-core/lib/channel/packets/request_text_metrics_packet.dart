import 'package:nexum_core/material/text_style.dart';
import 'package:nexum_core/channel/packet.dart';

class RequestTextMetricsPacket extends Packet {
  final String value;
  final TextStyle style;

  RequestTextMetricsPacket({
    required this.value,
    required this.style,
  });
}