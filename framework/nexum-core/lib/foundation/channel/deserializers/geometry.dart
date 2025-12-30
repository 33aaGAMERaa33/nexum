import '../../../painting/geometry.dart';
import '../friendly_buffer.dart';
import '../helper_deserializer.dart';

class OffsetDeserializer extends HelperDeserializer<Offset> {
  @override
  Offset deserialize(FriendlyBuffer friendlyBuffer) {
    return Offset(
        topPos: friendlyBuffer.readInt().toDouble(),
        leftPos: friendlyBuffer.readInt().toDouble(),
    );
  }

  @override
  String get identifier => "offset";

  @override
  Type get objectType => Offset;
}

class SizeDeserializer extends HelperDeserializer<Size> {
  @override
  Size deserialize(FriendlyBuffer friendlyBuffer) => Size(
    height: friendlyBuffer.readInt().toDouble(),
    width: friendlyBuffer.readInt().toDouble(),
  );

  @override
  String get identifier => "size";

  @override
  Type get objectType => Size;
}