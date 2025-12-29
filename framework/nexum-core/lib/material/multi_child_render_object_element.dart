import 'dart:math';

import 'package:nexum_core/exceptions/nexum_error.dart';
import 'package:nexum_core/material/render_object.dart';
import 'package:nexum_core/material/render_object_element.dart';
import 'package:nexum_core/material/widget.dart';

import 'element.dart';
import 'multi_child_render_object_widget.dart';

class MultiChildRenderObjectElement extends RenderObjectElement {
  List<Element> _childrens = [];
  MultiChildRenderObjectElement(MultiChildRenderObjectWidget super.widget);

  @override
  void mount(Element? parent, Object? slot) {
    super.mount(parent, slot);
    assert(renderObject != null);

    int i = 0;
    _throwIfHasDuplicatedKey(widget.childrens);

    for(final Widget childWidget in widget.childrens) {
      final Element child = childWidget.createElement();
      child.mount(this, i);


      if(child.renderObject != null) {
        renderObject!.adoptChild(child.renderObject!);
      }

      _childrens.add(child);
      i++;
    }
  }

  @override
  void unmount() {
    for(final Element child in _childrens) {
      child.unmount();
    }

    _childrens.clear();

    super.unmount();
  }

  @override
  void update(Widget newWidget) {
    super.update(newWidget);
    assert(this.renderObject != null);
    final RenderObject renderObject = this.renderObject!;

    final List<Element> newChildrens = [];
    final List<Widget> newChildWidgets = widget.childrens;
    final int length = max(_childrens.length, newChildWidgets.length);

    _throwIfHasDuplicatedKey(newChildWidgets);

    Element ? getOldChildByIndex(int index) => index < _childrens.length ? _childrens[index] : null;

    for(int i = 0; i < length; i++) {
      final Widget ? newChildWidget = i < newChildWidgets.length ? newChildWidgets[i] : null;
      late final Element ? oldChild;

      if(newChildWidget == null) {
        final Element ? findedOldChild = getOldChildByIndex(i);
        oldChild = findedOldChild?.widget.key == null ? findedOldChild : null;
      }else {
        if(newChildWidget.key == null) {
          oldChild = getOldChildByIndex(i);
        }else {
          bool finded = false;

          for(final Element otherOldChild in _childrens) {
            if(newChildWidget.key == otherOldChild.widget.key) {
              oldChild = otherOldChild;
              finded = true;
              break;
            }
          }

          if(!finded) oldChild = null;
        }
      }

      if(newChildWidget != null && oldChild != null) {
        assert(oldChild.renderObject != null);

        if(oldChild.canUpdate(newChildWidget)) {
          oldChild.update(newChildWidget);
          newChildrens.add(oldChild);
          continue;
        }

        final Element newChild = newChildWidget.createElement();
        newChild.mount(this, i);

        assert(newChild.renderObject != null);
        newChildrens.add(newChild);
      }else if(newChildWidget != null){
        final Element newChild = newChildWidget.createElement();
        newChild.mount(this, i);

        assert(newChild.renderObject != null);
        newChildrens.add(newChild);
      }else {
        assert(oldChild != null);
        assert(oldChild!.renderObject != null);
      }
    }

    for(final Element oldChild in _childrens) {
      assert(oldChild.renderObject != null);
      renderObject.dropChild(oldChild.renderObject!);

      if(newChildrens.contains(oldChild)) continue;
      oldChild.unmount();
    }

    for(final Element newChild in newChildrens) {
      assert(newChild.renderObject != null, "${newChild.mounted}");
      renderObject.adoptChild(newChild.renderObject!);
    }

    _childrens = newChildrens;
  }

  void _throwIfHasDuplicatedKey(List<Widget> childrens) {
    for(final Widget child in childrens) {
      for(final Widget otherChild in childrens) {
        if(child == otherChild) continue;
        else if(child.key == null || otherChild.key == null) continue;

        if(otherChild.key == child.key) throw NexumError(
            "Chave duplicada encontrada: ${child.key}\n"
            "Os Widgets: $child e $otherChild tem mesma chave\n"
                "As chaves devem ser únicas entre irmãos"
        );
      }
    }
  }

  @override
  MultiChildRenderObjectWidget get widget => super.widget as MultiChildRenderObjectWidget;
}