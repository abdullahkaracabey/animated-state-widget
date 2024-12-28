library animated_state_widget;

import 'package:animated_state_widget/controller.dart';
import 'package:animated_state_widget/widget_state.dart';
import 'package:flutter/material.dart';

class AnimatedStateWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final AnimatedStateController controller;

  const AnimatedStateWidget({
    Key? key,
    required this.child,
    required this.controller,
    this.duration = const Duration(milliseconds: 500),
  }) : super(key: key);
  @override
  AnimatedStateWidgetState createState() => AnimatedStateWidgetState();
}

class AnimatedStateWidgetState extends State<AnimatedStateWidget>
    with SingleTickerProviderStateMixin {
  var key = GlobalKey();
  bool isAnimating = true;
  Size? _size;

  @override
  void initState() {
    // SchedulerBinding.instance
    //     .addPostFrameCallback((_) => postFrameCallback(context));

    widget.controller.addListener(_onChangeState);
    super.initState();
  }

  _onChangeState() {
    if (widget.controller.state == AnimatedWidgetState.onAction) {
      postFrameCallback(context);
    } else {
      setState(() {});
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onChangeState);
    super.dispose();
  }

  Widget circularContainer() {
    var colorScheme = Theme.of(context).colorScheme;
    Color? color;
    Widget content;

    switch (widget.controller.state) {
      case AnimatedWidgetState.completed:
        color = colorScheme.primary;
        content = const Icon(Icons.done, color: Colors.white);
        break;
      case AnimatedWidgetState.error:
        color = colorScheme.error;
        content = const Icon(Icons.error, color: Colors.white);
        break;

      default:
        content = const CircularProgressIndicator(
          color: Colors.white,
        );
    }

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      // padding: const EdgeInsets.all(8),
      child: Center(
        child: content,
      ),
    );
  }

  void postFrameCallback(_) {
    try {
      var context = key.currentContext;
      if (context == null) {
        debugPrint("Context is nulll");
        return;
      }

      var newSize = context.size;

      if (newSize != null && _size == null) {
        debugPrint(
            "Container ${key.toString()} Size ${newSize.height} * ${newSize.width}");

        _size = newSize;
      }

      setState(() {});
    } catch (e) {
      debugPrint("Error on postFrameCallback $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    final buttonWidth = _size?.width;

    final isInit =
        isAnimating || widget.controller.state == AnimatedWidgetState.init;

    Color? color;
    // Widget content;

    switch (widget.controller.state) {
      case AnimatedWidgetState.init:
        color = Colors.transparent;
        break;
      case AnimatedWidgetState.completed:
      case AnimatedWidgetState.onAction:
        color = colorScheme.primary;
        // color = Colors.red;
        break;
      // case WidgetState.error:
      //   color = colorScheme.error;
      //   break;

      default:
        color = Colors.transparent;
    }
    return AnimatedContainer(
        padding: EdgeInsets.zero,
        key: key,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(
                widget.controller.state == AnimatedWidgetState.init
                    ? 0
                    : _size?.height ?? 70)),
        duration: widget.duration,
        onEnd: () => setState(() {
              isAnimating = !isAnimating;
            }),
        width: widget.controller.state == AnimatedWidgetState.init
            ? buttonWidth
            : _size?.height ?? 70,
        height: _size?.height,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.controller.state == AnimatedWidgetState.init
                  ? widget.child
                  : circularContainer()
            ]));
  }
}
