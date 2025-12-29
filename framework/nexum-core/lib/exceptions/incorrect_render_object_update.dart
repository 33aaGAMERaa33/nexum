import 'package:nexum_core/exceptions/exception_message.dart';
import 'package:nexum_core/material/render_object.dart';

class IncorrectRenderObjectUpdate extends ExceptionMessage {
  IncorrectRenderObjectUpdate(RenderObject provider, Type expected)
      : super("Provide: ${provider.runtimeType}, Expected: $expected");
}