import 'package:nexum_core/channel/friendly_buffer.dart';

abstract class HelperDeserializer<T> {
  String get identifier;
  Type get objectType;
  T deserialize(FriendlyBuffer friendlyBuffer);
}