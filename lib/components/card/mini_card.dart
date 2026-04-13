import 'package:flutter/widgets.dart';
import 'package:miniui/core/base/base_component.dart';

/// Card container used to wrap content and apply a consistent card style.
class MiniCard extends BaseComponent {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  const MiniCard({
    super.key,
    required this.child,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = themeOf(context);

    final Widget content = Padding(
      padding: padding == EdgeInsets.zero
          ? EdgeInsets.all(theme.spacing.md)
          : padding,
      child: child,
    );

    // Add a subtle shadow to approximate the card style in modern iOS.
    return Padding(
      padding: margin,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.colors.background,
          borderRadius: theme.radius.medium,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: theme.colors.foreground.withValues(alpha: 0.06),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: content,
      ),
    );
  }
}
