import 'package:flutter/widgets.dart';
import 'package:miniui/components/text/mini_text.dart';
import 'package:miniui/core/base/base_component.dart';

/// Configuration for a single tab item (label + optional icon).
class MiniTabItem {
  final String label;
  final Widget? icon;

  const MiniTabItem({
    required this.label,
    this.icon,
  });
}

/// Tab bar that shows a list of equally divided navigation items at
/// the top or bottom of the screen.
class MiniTabBar extends BaseComponent {
  final List<MiniTabItem> items;
  final int currentIndex;
  final ValueChanged<int>? onTap;
  final bool isBottom;

  const MiniTabBar({
    super.key,
    required this.items,
    required this.currentIndex,
    this.onTap,
    this.isBottom = true,
  });

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = themeOf(context);

    final Widget row = Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        for (int i = 0; i < items.length; i++)
          _buildItem(
            context,
            theme,
            items[i],
            i,
          ),
      ],
    );

    final EdgeInsetsGeometry padding = EdgeInsets.symmetric(
      horizontal: theme.spacing.lg,
      vertical: theme.spacing.sm,
    );

    final Border border = Border(
      top: isBottom
          ? BorderSide(
              color: theme.colors.foreground.withValues(alpha: 0.06),
            )
          : BorderSide.none,
      bottom: !isBottom
          ? BorderSide(
              color: theme.colors.foreground.withValues(alpha: 0.06),
            )
          : BorderSide.none,
    );

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: theme.colors.background,
        border: border,
      ),
      child: row,
    );
  }

  Widget _buildItem(
    BuildContext context,
    MiniTheme theme,
    MiniTabItem item,
    int index,
  ) {
    final bool selected = index == currentIndex;

    final Color color = selected
        ? theme.colors.primary
        : theme.colors.foreground.withValues(alpha: 0.6);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap == null ? null : () => onTap!(index),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: theme.spacing.sm),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (item.icon != null)
              IconTheme(
                data: IconThemeData(
                  color: color,
                  size: theme.spacing.lg,
                ),
                child: item.icon!,
              ),
            if (item.icon != null) SizedBox(height: theme.spacing.xs),
            MiniText(
              item.label,
              style: theme.typography.small.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
