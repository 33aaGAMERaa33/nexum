import 'dart:math';

import 'package:nexum_core/events/event.dart';
import 'package:nexum_core/helpers/logger.dart';
import 'package:nexum_core/material/component_element.dart';
import 'package:nexum_core/material/element.dart';
import 'package:nexum_core/material/paint_context.dart';
import 'package:nexum_core/material/render_object.dart';
import 'package:nexum_core/material/widget.dart';
import 'package:nexum_core/models/constraints.dart';
import 'package:nexum_core/models/offset.dart';
import 'package:nexum_core/models/size.dart';
import 'package:nexum_core/channel/packet_manager.dart';
import 'package:nexum_core/channel/packets/send_graphics_packet.dart';
import 'package:nexum_core/render/graphics.dart';
import 'package:nexum_core/types/void_callback.dart';
import 'package:nexum_core/widgets/view.dart';

class Nexum {
  Size screenSize;
  late int fpsLimit;
  late int frameTime;
  Element ? _rootElement;
  bool _isRunning = false;
  bool _isFirstBuild = true;
  final List<Event> _eventsToPropagate = [];
  PacketManager get _packetManager => PacketManager.instance;

  final List<RenderObject> _dirtyLayouts = [];
  final List<ComponentElement> _dirtyElements = [];
  final List<RenderObject> _dirtyRenderObjects = [];
  final List<VoidCallback> _scheduledsForTheNextCycle = [];

  static Nexum ? _instance;
  static Nexum get instance => _instance!;
  static bool get initialized => _instance != null;

  bool get isRunning => _isRunning;
  final PaintContext _paintContext = PaintContext();

  Nexum._({
    required int fpsLimit,
    required this.screenSize,
  }) {
    this.fpsLimit = min(360, fpsLimit);
    frameTime = (1_000 / fpsLimit).toInt();
  }

  static Nexum initialize({
    required int fpsLimit,
    required Size screenSize,
  }) {
    assert(_instance == null);
    final Nexum nexum = Nexum._(fpsLimit: fpsLimit, screenSize: screenSize);
    _instance = nexum;

    return nexum;
  }

  void start(Widget widget) async {
    if(_isRunning) return;
    _isRunning = true;
    _isFirstBuild = true;

    final Element rootElement = View(child: widget).createElement();
    _rootElement = rootElement;

    rootElement.mount(null, null);

    while(_isRunning) {
      final int start = DateTime.now().millisecondsSinceEpoch;
      _processScheduledForNextCycle();
      _propagateEvents();

      await _prePaint();
      final bool painted = _paint();

      if(painted) {
        final Graphics graphics = Graphics();
        _paintContext.paint(graphics);

        _packetManager.sendPacket(SendGraphicsPacket(graphics));
      }

      final int elapsed = DateTime.now().millisecondsSinceEpoch - start;
      final int remaining = frameTime - elapsed;

      if(remaining > 0) await Future.delayed(Duration(milliseconds: remaining));
      _isFirstBuild = false;
    }
  }

  void stop() {
    _isRunning = false;
    _rootElement?.unmount();
  }

  bool _paint() {
    final Offset offset = Offset.zero();

    if(_isFirstBuild) {
      final Element ? rootElement = _rootElement;

      if(rootElement != null) {
        rootElement.renderObject!.paint(_paintContext, offset);
        return true;
      }
    }else if(_dirtyRenderObjects.isNotEmpty) {
      _paintContext.paintCommands.removeWhere((element) {
        return element.dirty || _dirtyRenderObjects.contains(element.owner);
      });

      for(final RenderObject dirtyRenderObject in _dirtyRenderObjects) {
        dirtyRenderObject.paint(_paintContext, offset);
      }

      _dirtyRenderObjects.clear();
      return true;
    }

    return false;
  }

  Future<void> _prePaint() async {
    if(_isFirstBuild) {
      final Constraints constraints = Constraints(
        minWidth: 0, maxWidth: screenSize.width,
        minHeight: 0, maxHeight: screenSize.height,
      );

      final RenderObject ? renderObject = _rootElement?.renderObject;

      if(renderObject != null) {
        await renderObject.prepareLayout();
        renderObject.layout(constraints);
      }
    }else if(_dirtyElements.isNotEmpty || _dirtyLayouts.isNotEmpty){
      for(final ComponentElement element in _dirtyElements) {
        element.rebuild();
      }

      for(final RenderObject dirtyLayout in _dirtyLayouts) {
        await dirtyLayout.relayout();
      }

      _dirtyLayouts.clear();
      _dirtyElements.clear();
    }
  }

  void propagateEvent<T extends Event>(T event) {
    _eventsToPropagate.add(event);
  }

  void _propagateEvents() {
    if(!initialized || _eventsToPropagate.isEmpty) return;
    final RenderObject ? rootElementRenderObject = _rootElement?.renderObject;

    if(rootElementRenderObject == null || rootElementRenderObject.isNeedsPaint) return;

    for(final Event event in _eventsToPropagate) {
      try {
        rootElementRenderObject.propagateEvent(event);
      }catch(e, stack) {
        _error(stack.toString());
        _error(e.toString());
      }
    }

    _eventsToPropagate.clear();
  }

  void _processScheduledForNextCycle() {
    final List<VoidCallback> callbacks = _scheduledsForTheNextCycle.toList();
    _scheduledsForTheNextCycle.clear();

    for(final VoidCallback callback in callbacks) {
      callback.call();
    }
  }

  void scheduleForNextCycle(VoidCallback callback) {
    _scheduledsForTheNextCycle.add(callback);
  }

  void scheduleBuildFor(ComponentElement element) {
    if(_dirtyElements.contains(element)) return;
    _dirtyElements.add(element);
  }

  void scheduleLayoutFor(RenderObject renderObject) {
    if(_dirtyLayouts.contains(renderObject)) return;
    _dirtyLayouts.add(renderObject);
  }

  void schedulePaintFor(RenderObject renderObject) {
    if(_dirtyRenderObjects.contains(renderObject)) return;
    _dirtyRenderObjects.add(renderObject);
  }

  void _log(String log) {
    Logger.log("Nexum", log);
  }

  void _error(String log) {
    Logger.error("Nexum", log);
  }
}