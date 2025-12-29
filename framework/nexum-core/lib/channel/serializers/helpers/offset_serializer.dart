import 'package:nexum_core/models/offset.dart';
import 'package:nexum_core/channel/friendly_buffer.dart';
import 'package:nexum_core/channel/helper_serializer.dart';

class OffsetSerializer extends HelperSerializer<Offset> {
  @override
  String get identifier => "offset";

  @override
  Type get objectType => Offset;

  @override
  void serialize(Offset object, FriendlyBuffer friendlyBuffer) {
    friendlyBuffer.writeInt(object.leftPos);
    friendlyBuffer.writeInt(object.topPos);
  }
}