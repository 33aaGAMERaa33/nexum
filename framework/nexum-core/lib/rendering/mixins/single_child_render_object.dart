import '../object.dart';

mixin SingleChildRenderObject on RenderObject {
  RenderObject ? child;

  @override
  void update() {
    super.update();
    child?.markNeedsPaint();
    child?.markNeedsLayout();
  }

  @override
  void adoptChild(RenderObject child) {
    super.adoptChild(child);
    this.child = child;
  }

  @override
  void dropChild(RenderObject child) {
    super.dropChild(child);
    this.child = null;
  }
}