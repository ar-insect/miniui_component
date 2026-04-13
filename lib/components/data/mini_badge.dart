import 'package:flutter/widgets.dart';
import 'package:miniui/core/base/base_component.dart';

/// Badge component that can be overlaid on the top-right of a child widget,
/// supporting numeric badges and dot badges.
class MiniBadge extends BaseComponent {
  final Widget? child;
  final String? value;
  final bool dot;

  const MiniBadge({
    super.key,
    this.child,
    this.value,
    this.dot = false,
  });

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = themeOf(context);

    final Widget badge = dot ? _buildDot(theme) : _buildLabel(theme);

    if (child == null) {
      return badge;
    }

    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        child!,
        Positioned(
          right: -theme.spacing.xs,
          top: -theme.spacing.xs,
          child: badge,
        ),
      ],
    );
  }

  Widget _buildDot(MiniTheme theme) {
    return Container(
      width: theme.spacing.sm,
      height: theme.spacing.sm,
      decoration: BoxDecoration(
        color: theme.colors.danger,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildLabel(MiniTheme theme) {
    final String text = value ?? '';

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: theme.spacing.xs,
        vertical: 1.5,
      ),
      decoration: BoxDecoration(
        color: theme.colors.danger,
        borderRadius: theme.radius.pill,
      ),
      child: Text(
        text,
        style: theme.typography.small.copyWith(
          color: theme.colors.background,
          fontSize: 10,
        ),
      ),
    );
  }
}
