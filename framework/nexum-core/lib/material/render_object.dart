import 'package:meta/meta.dart';
import 'package:nexum_core/core/nexum.dart';
import 'package:nexum_core/events/event.dart';
import 'package:nexum_core/events/pointer_event.dart';
import 'package:nexum_core/material/element.dart';
import 'package:nexum_core/render/mixins/multi_child_render_object.dart';
import 'package:nexum_core/material/paint_command.dart';
import 'package:nexum_core/material/paint_command_recorder.dart';
import 'package:nexum_core/models/constraints.dart';
import 'package:nexum_core/models/offset.dart';
import 'package:nexum_core/render/mixins/single_child_render_object.dart';

abstract class RenderObject {
  Element ? _owner;
  @protected
  bool needsPaint = true;
  @protected
  bool needsLayout = true;
  @protected
  bool disposed = false;

  bool get isNeedsPaint => needsPaint;
  bool get isNeedsLayout => needsLayout;

  RenderObject ? parent;
  PaintCommand ? _paintCommand;

  Offset ? _absoluteOffset;
  Offset ? _relativeOffset;
  Constraints ? _constraints;

  set constraints(Constraints constraints) => _constraints = constraints;
  Constraints get constraints => _constraints!;

  @protected
  set paintCommand(PaintCommand ? paintCommand) {
    _paintCommand?.markDirty();
    _paintCommand = paintCommand;
  }

  @protected
  PaintCommand ? get paintCommand => _paintCommand;

  set absoluteOffset(Offset offset) => _absoluteOffset = offset;
  Offset get absoluteOffset => _absoluteOffset!;

  set relativeOffset(Offset offset) => _relativeOffset = offset;
  Offset get relativeOffset => _relativeOffset!;

  void update() {
    markNeedsPaint();
    markNeedsLayout();
  }

  void paint(PaintCommandRecorder paintRecorder, Offset offset);

  void repaint(PaintCommandRecorder paintRecorder) {
    if(!needsPaint) return;
    paint(paintRecorder, relativeOffset);
  }

  void layout(Constraints constraints);

  Future<void> relayout() async {
    if(!needsLayout) return;
    await prepareLayout();
    layout(constraints);
  }

  Future<void> prepareLayout();

  void propagateEvent<T extends Event>(T event) {
    if(event is PointerEvent) {
      if(hitTest(event.position)) {
        if(this is SingleChildRenderObject) {
          (this as SingleChildRenderObject).child?.propagateEvent(event);
        }else if(this is MultiChildRenderObject){
          for(final RenderObject child in (this as MultiChildRenderObject).childrens) {
            child.propagateEvent(event);
          }
        }
      }
    }
  }

  bool hitTest(Offset position);

  void markNeedsPaint() {
    if(needsPaint) return;
    needsPaint = true;
    _paintCommand?.markDirty();

    if(parent != null) {
      parent!.markNeedsPaint();
    }else {
      Nexum.instance.schedulePaintFor(this);
    }
  }

  void markNeedsLayout() {
    if(needsLayout) return;
    needsLayout = true;
    _paintCommand?.markDirty();

    if(parent != null && parent!.needsChildLayout) {
      parent!.markNeedsLayout();
    }else {
      Nexum.instance.scheduleLayoutFor(this);
    }
  }

  bool get needsChildLayout;

  void adoptChild(RenderObject child) {
    assert(child.parent == null);
    child.parent = this;
  }

  void dropChild(RenderObject child) {
    assert(child.parent == this);
    child.parent = null;
  }

  void updateChild(RenderObject oldChild, RenderObject newChild) {
    assert(oldChild.parent == this);
    assert(newChild.parent == null);

    oldChild.parent = null;
    newChild.parent = this;
  }

  void attach(Element owner) {
    assert(_owner == null);
    _owner = owner;
  }

  void deattach() {
    assert(_owner != null);
    _owner = null;
  }

  void dispose() {
    if(disposed) return;
    disposed = true;
    paintCommand?.markDirty();
  }
}