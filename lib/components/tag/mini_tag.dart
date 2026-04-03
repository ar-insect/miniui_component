import 'package:flutter/widgets.dart';
import 'package:miniui/core/base/base_component.dart';

class MiniTag extends BaseComponent {
  final String label;
  final EdgeInsetsGeometry padding;
  final bool filled;
  final bool closable;
  final VoidCallback? onClose;

  const MiniTag({
    super.key,
    required this.label,
    this.padding = EdgeInsets.zero,
    this.filled = true,
    this.closable = false,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = themeOf(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: filled
            ? theme.colors.accent.withOpacity(0.15)
            : theme.colors.background,
        borderRadius: theme.radius.pill,
        border: filled
            ? null
            : Border.all(
                color: theme.colors.accent.withOpacity(0.6),
              ),
      ),
      child: Padding(
        padding: padding == EdgeInsets.zero
            ? EdgeInsets.symmetric(
                horizontal: theme.spacing.sm,
                vertical: theme.spacing.xs,
              )
            : padding,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            DefaultTextStyle(
              style: theme.typography.small
                  .copyWith(color: theme.colors.accent),
              child: Text(label),
            ),
            if (closable && onClose != null) ...<Widget>[
              SizedBox(width: theme.spacing.xs),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onClose,
                child: Container(
                  width: theme.spacing.sm,
                  height: theme.spacing.sm,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.colors.accent.withOpacity(0.2),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
