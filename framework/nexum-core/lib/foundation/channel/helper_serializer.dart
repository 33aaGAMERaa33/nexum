import 'friendly_buffer.dart';

abstract class HelperSerializer<T> {
  String get identifier;
  Type get objectType;
  void serialize(T object, FriendlyBuffer friendlyBuffer);
}