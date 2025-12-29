import 'package:nexum_core/material/widget.dart';

/// Contexto utilizado durante a fase de build de um widget.
///
/// O [BuildContext] fornece acesso ao widget associado
/// e serve como base para futuras extensões do sistema
/// de construção da árvore de widgets.
abstract class BuildContext {
  /// Widget associado a este contexto de build
  Widget widget;

  /// Cria um novo contexto de build associado a um widget.
  BuildContext(this.widget);
}
