import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:miniui/core/base/base_component.dart';
import 'package:miniui/core/painters/loading_painter.dart';

/// Spinning ring loading indicator rendered with a custom painter.
class MiniLoading extends StatefulWidget {
  final double size;

  const MiniLoading({
    super.key,
    this.size = 24,
  });

  @override
  State<MiniLoading> createState() => _MiniLoadingState();
}

class _MiniLoadingState extends State<MiniLoading>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = MiniThemeProvider.of(context);

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          return Transform.rotate(
            angle: _controller.value * 2 * math.pi,
            child: child,
          );
        },
        child: CustomPaint(
          painter: MiniLoadingPainter(
            color: theme.colors.primary,
          ),
        ),
      ),
    );
  }
}
