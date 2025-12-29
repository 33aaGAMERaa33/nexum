import 'package:nexum_core/models/size.dart';
import 'package:nexum_core/channel/friendly_buffer.dart';
import 'package:nexum_core/channel/helper_deserializer.dart';

class SizeDeserializer extends HelperDeserializer<Size> {
  @override
  Size deserialize(FriendlyBuffer friendlyBuffer) => Size(
      height: friendlyBuffer.readInt(),
      width: friendlyBuffer.readInt(),
  );

  @override
  String get identifier => "size";

  @override
  Type get objectType => Size;
}