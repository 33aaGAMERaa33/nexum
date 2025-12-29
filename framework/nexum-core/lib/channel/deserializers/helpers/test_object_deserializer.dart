import 'package:nexum_core/material/test_object.dart';
import 'package:nexum_core/channel/friendly_buffer.dart';
import 'package:nexum_core/channel/helper_deserializer.dart';

class TestObjectDeserializer extends HelperDeserializer<TestObject> {
  @override
  String get identifier => "test_object";

  @override
  Type get objectType => TestObject;

  @override
  TestObject deserialize(FriendlyBuffer friendlyBuffer) {
    return TestObject(friendlyBuffer.readString());
  }
}