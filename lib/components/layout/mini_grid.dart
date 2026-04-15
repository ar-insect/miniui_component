import 'package:flutter/widgets.dart';
import 'package:miniui_component/core/base/base_component.dart';
import 'package:miniui_component/components/text/mini_text.dart';

class MiniGridItem {
  final Widget icon;
  final String? title;
  final String? subtitle;
  final Widget? titleWidget;
  final Widget? subtitleWidget;
  final VoidCallback? onTap;

  const MiniGridItem({
    required this.icon,
    this.title,
    this.subtitle,
    this.titleWidget,
    this.subtitleWidget,
    this.onTap,
  });
}

class MiniGrid extends BaseComponent {
  final List<MiniGridItem> items;
  final int columns;
  final double spacing;
  final EdgeInsetsGeometry? padding;
  final double? maxItemWidth;
  final double childAspectRatio;

  const MiniGrid({
    super.key,
    required this.items,
    this.columns = 3,
    this.spacing = 12,
    this.padding,
    this.maxItemWidth,
    this.childAspectRatio = 1,
  });

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = themeOf(context);

    final EdgeInsetsGeometry resolvedPadding =
        padding ?? EdgeInsets.all(theme.spacing.sm);

    return Padding(
      padding: resolvedPadding,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        gridDelegate: maxItemWidth != null
            ? SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: maxItemWidth!,
                crossAxisSpacing: spacing,
                mainAxisSpacing: spacing,
                childAspectRatio: childAspectRatio,
              )
            : SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                crossAxisSpacing: spacing,
                mainAxisSpacing: spacing,
                childAspectRatio: childAspectRatio,
              ),
        itemBuilder: (BuildContext context, int index) {
          final MiniGridItem item = items[index];
          final Widget? titleWidget = item.titleWidget ??
              (item.title != null
                  ? MiniText(
                      item.title!,
                      style: theme.typography.small.copyWith(
                        color: theme.colors.foreground,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  : null);
          final Widget? subtitleWidget = item.subtitleWidget ??
              (item.subtitle != null && item.subtitle!.isNotEmpty
                  ? MiniText(
                      item.subtitle!,
                      style: theme.typography.small.copyWith(
                        color: theme.colors.foreground
                            .withValues(alpha: 0.6),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  : null);

          final Widget content = Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              item.icon,
              if (titleWidget != null) ...<Widget>[
                SizedBox(height: theme.spacing.xs),
                titleWidget,
              ],
              if (subtitleWidget != null) ...<Widget>[
                SizedBox(height: theme.spacing.xs),
                subtitleWidget,
              ],
            ],
          );

          if (item.onTap == null) {
            return content;
          }

          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: item.onTap,
            child: content,
          );
        },
      ),
    );
  }
}
