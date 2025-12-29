import 'package:nexum_core/material/test_object.dart';
import 'package:nexum_core/channel/friendly_buffer.dart';
import 'package:nexum_core/channel/helper_serializer.dart';

class TestObjectSerializer extends HelperSerializer<TestObject> {
  @override
  String get identifier => "test_object";

  @override
  Type get objectType => TestObject;

  @override
  void serialize(TestObject object, FriendlyBuffer friendlyBuffer) {
    friendlyBuffer.writeString(object.message);
  }
}