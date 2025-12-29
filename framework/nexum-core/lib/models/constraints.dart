import 'package:nexum_core/material/max_int.dart';

import 'package:nexum_core/material/max_int.dart';

class Constraints {
  final int minWidth;
  final int maxWidth;
  final int minHeight;
  final int maxHeight;

  const Constraints({
    this.minWidth = 0,
    required this.maxWidth,
    this.minHeight = 0,
    required this.maxHeight,
  })  : assert(minWidth >= 0),
        assert(minHeight >= 0),
        assert(maxWidth >= minWidth),
        assert(maxHeight >= minHeight);

  /// Largura é limitada (não infinita)
  bool get hasBoundedWidth => maxWidth < maxInt;

  /// Altura é limitada (não infinita)
  bool get hasBoundedHeight => maxHeight < maxInt;

  /// Ambos os eixos são limitados
  bool get isBounded => hasBoundedWidth && hasBoundedHeight;

  /// Nenhum eixo é limitado
  bool get isUnbounded => !hasBoundedWidth && !hasBoundedHeight;

  /// Pelo menos um eixo é ilimitado
  bool get hasUnboundedAxis => !isBounded;

  /// Verifica se um tamanho cabe dentro das constraints
  bool allows(int width, int height) {
    return width >= minWidth &&
        width <= maxWidth &&
        height >= minHeight &&
        height <= maxHeight;
  }

  @override
  String toString() => "Constraints(minWidth: $minWidth, maxWidth: $maxWidth, minHeight: $minHeight, maxHeight: $maxHeight)";
}
