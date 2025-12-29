import 'package:nexum_core/channel/friendly_buffer.dart';

abstract class Dto {
  void serialize(FriendlyBuffer friendlyBuffer);
}