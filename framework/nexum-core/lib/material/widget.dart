import 'package:nexum_core/material/element.dart';
import 'package:nexum_core/material/key.dart';

abstract class Widget {
  const Widget({this.key});
  final Key ? key;
  Element createElement();
}