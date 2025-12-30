import 'package:nexum_core/ui/color.dart';
import 'package:nexum_core/material/colors.dart';
import 'package:nexum_core/ui/font.dart';

class TextStyle {
  final Font font;
  final Color color;

  const TextStyle({
    this.font = const Font(fontSize: 16),
    this.color = Colors.black,
  });
}