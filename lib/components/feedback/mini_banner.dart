import 'package:flutter/widgets.dart';
import 'package:miniui_component/core/base/base_component.dart';
import 'package:miniui_component/components/text/mini_text.dart';

enum MiniBannerVariant {
  info,
  success,
  warning,
  danger,
}

class MiniBanner extends BaseComponent {
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;
  final MiniBannerVariant variant;
  final bool dense;

  const MiniBanner({
    super.key,
    required this.message,
    this.actionLabel,
    this.onAction,
    this.variant = MiniBannerVariant.info,
    this.dense = false,
  });

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = themeOf(context);

    Color base;
    switch (variant) {
      case MiniBannerVariant.info:
        base = theme.colors.primary;
        break;
      case MiniBannerVariant.success:
        base = theme.colors.accent;
        break;
      case MiniBannerVariant.warning:
        base = theme.colors.accent.withValues(alpha: 0.9);
        break;
      case MiniBannerVariant.danger:
        base = theme.colors.danger;
        break;
    }

    final Color background =
        base.withValues(alpha: 0.08);
    final Color border =
        base.withValues(alpha: 0.18);
    final Color textColor = theme.colors.foreground;

    final EdgeInsetsGeometry padding = EdgeInsets.symmetric(
      horizontal: theme.spacing.md,
      vertical: dense ? theme.spacing.xs : theme.spacing.sm,
    );

    final List<Widget> rowChildren = <Widget>[
      Expanded(
        child: MiniText(
          message,
          style: theme.typography.small.copyWith(
            color: textColor,
          ),
        ),
      ),
    ];

    if (actionLabel != null && onAction != null) {
      rowChildren.add(SizedBox(width: theme.spacing.sm));
      rowChildren.add(
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onAction,
          child: MiniText(
            actionLabel!,
            style: theme.typography.small.copyWith(
              color: base,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: background,
        borderRadius: theme.radius.medium,
        border: Border.all(color: border),
      ),
      child: Padding(
        padding: padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: rowChildren,
        ),
      ),
    );
  }
}
