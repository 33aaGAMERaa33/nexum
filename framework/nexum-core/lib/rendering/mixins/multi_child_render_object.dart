import '../object.dart';

mixin MultiChildRenderObject on RenderObject {
  final List<RenderObject> childrens = [];

  @override
  void adoptChild(RenderObject child) {
    super.adoptChild(child);
    if(childrens.contains(child)) return;
    childrens.add(child);
  }

  @override
  void dropChild(RenderObject child) {
    childrens.remove(child);
    super.dropChild(child);
  }

  @override
  void updateChild(RenderObject oldChild, RenderObject newChild) {
    super.updateChild(oldChild, newChild);

    if(!childrens.contains(oldChild)) {
      childrens.add(newChild);
      return;
    }

    final int index = childrens.indexOf(oldChild);

    childrens.removeAt(index);
    childrens.insert(index, newChild);
  }
}