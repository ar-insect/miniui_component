import 'package:flutter/widgets.dart';
import 'package:miniui/miniui.dart';

/// Generic bottom sheet container used to present arbitrary content
/// from the bottom of the screen.
class MiniBottomSheet extends BaseComponent {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final bool showHandle;

  const MiniBottomSheet({
    super.key,
    required this.child,
    this.padding,
    this.showHandle = true,
  });

  /// Show a bottom sheet using a custom route and return the result of [T]
  /// passed to [Navigator.pop].
  static Future<T?> show<T>(
    BuildContext context, {
    required WidgetBuilder builder,
    bool barrierDismissible = true,
    Color barrierColor = const Color(0x99000000),
  }) {
    return Navigator.of(context).push<T>(
      PageRouteBuilder<T>(
        opaque: false,
        barrierDismissible: barrierDismissible,
        barrierColor: barrierColor,
        pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          final Widget sheet = builder(context);

          return Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              widthFactor: 1,
              child: _MiniDraggableBottomSheet(
                animation: animation,
                child: sheet,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = themeOf(context);

    // Panel inner padding: 20 (horizontal) x 16 (vertical) by default,
    // following an 8dp-based vertical rhythm.
    final EdgeInsetsGeometry resolvedPadding =
        padding ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 16);

    final List<Widget> columnChildren = <Widget>[];

    if (showHandle) {
      columnChildren.add(
        Padding(
          padding: const EdgeInsets.only(
            top: 12,
            bottom: 8,
          ),
          child: Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFE0E0E0),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ),
      );
    }

    columnChildren.add(
      Padding(
        padding: resolvedPadding,
        child: child,
      ),
    );

    return Padding(
      padding: EdgeInsets.only(
        left: theme.spacing.lg,
        right: theme.spacing.lg,
        bottom: theme.spacing.lg,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.colors.background,
          borderRadius: BorderRadius.only(
            topLeft: theme.radius.large.topLeft,
            topRight: theme.radius.large.topRight,
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: theme.colors.foreground.withValues(alpha: 0.12),
              blurRadius: 24,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: columnChildren,
          ),
        ),
      ),
    );
  }
}

class _MiniDraggableBottomSheet extends StatefulWidget {
  final Animation<double> animation;
  final Widget child;

  const _MiniDraggableBottomSheet({
    required this.animation,
    required this.child,
  });

  @override
  State<_MiniDraggableBottomSheet> createState() =>
      _MiniDraggableBottomSheetState();
}

class _MiniDraggableBottomSheetState extends State<_MiniDraggableBottomSheet>
    with SingleTickerProviderStateMixin {
  double _dragOffset = 0;
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 180),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    final double delta = details.delta.dy;
    if (delta <= 0) {
      return;
    }
    setState(() {
      _dragOffset = (_dragOffset + delta).clamp(0.0, 400.0);
    });
  }

  void _handleDragEnd(DragEndDetails details) {
    final double velocity = details.primaryVelocity ?? 0;
    final bool shouldDismiss =
        _dragOffset > 120 || velocity > 700;

    if (shouldDismiss) {
      Navigator.of(context).pop();
      return;
    }

    final double startOffset = _dragOffset;
    _controller
      ..value = 0
      ..forward();
    _controller.addListener(() {
      setState(() {
        _dragOffset = startOffset * (1 - _controller.value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> curvedAnimation = CurvedAnimation(
      parent: widget.animation,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );

    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(curvedAnimation),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onVerticalDragUpdate: _handleDragUpdate,
        onVerticalDragEnd: _handleDragEnd,
        child: Transform.translate(
          offset: Offset(0, _dragOffset),
          child: widget.child,
        ),
      ),
    );
  }
}
