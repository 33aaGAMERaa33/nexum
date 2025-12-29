import 'package:nexum_core/channel/friendly_buffer.dart';
import 'package:nexum_core/channel/helper_serializer.dart';
import 'package:nexum_core/models/size.dart';

class SizeSerializer extends HelperSerializer<Size> {
  @override
  void serialize(Size object, FriendlyBuffer friendlyBuffer) {
    friendlyBuffer.writeInt(object.width);
    friendlyBuffer.writeInt(object.height);
  }

  @override
  String get identifier => "size";

  @override
  Type get objectType => Size;
}