import 'package:flutter/widgets.dart';
import 'package:miniui_component/core/base/base_component.dart';

enum MiniTagTone {
  neutral,
  success,
  danger,
}

/// Tag component to display status text, supporting filled/outlined and
/// optional close button styles.
class MiniTag extends BaseComponent {
  final String label;
  final MiniTagTone tone;
  final EdgeInsetsGeometry padding;
  final bool filled;
  final bool closable;
  final VoidCallback? onClose;

  const MiniTag({
    super.key,
    required this.label,
    this.tone = MiniTagTone.neutral,
    this.padding = EdgeInsets.zero,
    this.filled = true,
    this.closable = false,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = themeOf(context);

    Color baseColor;
    switch (tone) {
      case MiniTagTone.neutral:
        baseColor = theme.colors.accent;
        break;
      case MiniTagTone.success:
        baseColor = theme.colors.primary;
        break;
      case MiniTagTone.danger:
        baseColor = theme.colors.danger;
        break;
    }

    final EdgeInsetsGeometry resolvedPadding = padding == EdgeInsets.zero
        ? EdgeInsets.symmetric(
            horizontal: theme.spacing.sm,
            vertical: theme.spacing.xs,
          )
        : padding;

    final TextStyle labelStyle =
        theme.typography.small.copyWith(color: baseColor);

    final Widget labelText = DefaultTextStyle(
      style: labelStyle,
      child: Text(label),
    );

    Widget? closeButton;
    if (closable && onClose != null) {
      closeButton = GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onClose,
        child: Container(
          width: theme.spacing.sm,
          height: theme.spacing.sm,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: baseColor.withValues(alpha: 0.2),
          ),
        ),
      );
    }

    final List<Widget> children = <Widget>[labelText];
    if (closeButton != null) {
      children.add(SizedBox(width: theme.spacing.xs));
      children.add(closeButton);
    }

    final Widget content = Padding(
      padding: resolvedPadding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: filled
            ? baseColor.withValues(alpha: 0.15)
            : theme.colors.background,
        borderRadius: theme.radius.pill,
        border: filled
            ? null
            : Border.all(
                color: baseColor.withValues(alpha: 0.6),
              ),
      ),
      child: content,
    );
  }
}
