import 'package:nexum_core/exceptions/incorrect_render_object_update.dart';
import 'package:nexum_core/helpers/logger.dart';
import 'package:nexum_core/material/leaf_child_render_object_widget.dart';
import 'package:nexum_core/material/render_object.dart';
import 'package:nexum_core/material/text_style.dart';

import '../render/renderers/render_paragraph.dart';

class RichText extends LeafChildRenderObjectWidget {
  final String value;
  final TextStyle style;

  const RichText(this.value, {
    this.style = const TextStyle()
  });

  @override
  RenderObject createRenderObject() => RenderParagraph(
    value: value,
    style: style
  );

  @override
  void updateRenderObject(RenderObject renderObject) {
    if(renderObject is! RenderParagraph) throw IncorrectRenderObjectUpdate(renderObject, RenderParagraph);
    //Logger.log("identifier", "old: ${renderObject.value} new: $value");

    renderObject.value = value;
    renderObject.style = style;
    renderObject.update();
  }

  @override
  String toString() => "RichText(value: $value)";
}