import 'package:nexum_core/core/services/helper_deserializer_service.dart';
import 'package:nexum_core/material/text_metrics.dart';
import 'package:nexum_core/channel/friendly_buffer.dart';
import 'package:nexum_core/channel/helper_deserializer.dart';

class TextMetricsDeserializer extends HelperDeserializer<TextMetrics> {
  @override
  String get identifier => "text_metrics";

  @override
  Type get objectType => TextMetrics;

  @override
  TextMetrics deserialize(FriendlyBuffer friendlyBuffer) {
    return TextMetrics(
        size: HelperDeserializerService.instance.deserializeObject(friendlyBuffer),
    );
  }
}