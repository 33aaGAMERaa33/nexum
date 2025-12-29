import 'package:nexum_core/material/text_metrics.dart';
import 'package:nexum_core/channel/packet.dart';

class SendTextMetricsPacket extends Packet {
  final TextMetrics textMetrics;
  SendTextMetricsPacket(this.textMetrics);
}