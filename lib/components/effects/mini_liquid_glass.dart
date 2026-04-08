import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:miniui/core/base/base_component.dart';

class MiniLiquidGlass extends StatefulWidget {
  final Widget child;
  final BorderRadius? borderRadius;
  final Duration duration;

  const MiniLiquidGlass({
    super.key,
    required this.child,
    this.borderRadius,
    this.duration = const Duration(seconds: 10),
  });

  @override
  State<MiniLiquidGlass> createState() => _MiniLiquidGlassState();
}

class _MiniLiquidGlassState extends State<MiniLiquidGlass>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = MiniThemeProvider.of(context);
    final BorderRadius radius =
        widget.borderRadius ?? theme.radius.large;

    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        final double t = _controller.value * 2 * math.pi;
        final Alignment lightCenter = Alignment(
          0.5 * math.sin(t),
          0.5 * math.cos(t),
        );

        final BoxDecoration innerDecoration = BoxDecoration(
          gradient: RadialGradient(
            center: lightCenter,
            radius: 1.2,
            colors: <Color>[
              theme.colors.background.withValues(alpha: 0.22),
              theme.colors.background.withValues(alpha: 0.10),
              theme.colors.background.withValues(alpha: 0.02),
            ],
          ),
        );

        final Widget content = DecoratedBox(
          decoration: innerDecoration,
          child: widget.child,
        );

        return MiniGlassSurface(
          theme: theme,
          borderRadius: radius,
          backgroundColor:
              theme.colors.background.withValues(alpha: 0.20),
          border: Border.all(
            color: theme.colors.foreground.withValues(alpha: 0.10),
          ),
          child: content,
        );
      },
    );
  }
}

