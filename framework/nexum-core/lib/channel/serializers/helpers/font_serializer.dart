import 'package:nexum_core/material/font.dart';
import 'package:nexum_core/channel/friendly_buffer.dart';
import 'package:nexum_core/channel/helper_serializer.dart';

class FontSerializer extends HelperSerializer<Font> {
  @override
  String get identifier => "font";

  @override
  Type get objectType => Font;

  @override
  void serialize(Font object, FriendlyBuffer friendlyBuffer) {
    friendlyBuffer.writeInt(object.fontSize);
  }
}