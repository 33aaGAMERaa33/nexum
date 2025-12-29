import 'package:nexum_core/models/color.dart';
import 'package:nexum_core/channel/friendly_buffer.dart';
import 'package:nexum_core/channel/helper_serializer.dart';

class ColorSerializer extends HelperSerializer<Color> {
  @override
  String get identifier => "color";

  @override
  Type get objectType => Color;

  @override
  void serialize(Color object, FriendlyBuffer friendlyBuffer) {
    friendlyBuffer.writeInt(object.red);
    friendlyBuffer.writeInt(object.green);
    friendlyBuffer.writeInt(object.blue);
  }
}