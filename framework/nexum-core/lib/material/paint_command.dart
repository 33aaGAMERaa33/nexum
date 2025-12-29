import 'package:nexum_core/models/size.dart';
import 'package:nexum_core/render/graphics.dart';
import 'package:nexum_core/material/render_object.dart';
import 'package:nexum_core/models/offset.dart';
import 'package:uuid/uuid.dart';

abstract class PaintCommand {
  RenderObject owner;
  bool _dirty = false;
  final Size size;
  final Offset offset;
  final String uuid = uuidFactory.v4();
  static const Uuid uuidFactory = Uuid();

  bool get dirty => _dirty;

  PaintCommand({
    required this.owner,
    required this.size,
    required this.offset,
  });

  void paint(Graphics graphics);

  void markDirty() {
    if(_dirty) return;
    _dirty = true;
  }
}