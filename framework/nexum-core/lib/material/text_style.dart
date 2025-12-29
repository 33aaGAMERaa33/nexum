import 'package:nexum_core/material/font.dart';
import 'package:nexum_core/models/color.dart';
import 'package:nexum_core/material/colors.dart';

class TextStyle {
  final Font font;
  final Color color;

  const TextStyle({
    this.font = const Font(),
    this.color = Colors.black,
  });
}