import 'package:nexum_core/models/offset.dart';
import 'package:nexum_core/channel/friendly_buffer.dart';
import 'package:nexum_core/channel/helper_deserializer.dart';

class OffsetDeserializer extends HelperDeserializer<Offset> {
  @override
  Offset deserialize(FriendlyBuffer friendlyBuffer) {
    final int topPos = friendlyBuffer.readInt();
    final int leftPos = friendlyBuffer.readInt();

    return Offset(leftPos: leftPos, topPos: topPos);
  }

  @override
  String get identifier => "offset";

  @override
  Type get objectType => Offset;
}