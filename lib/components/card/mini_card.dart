import 'package:flutter/widgets.dart';
import 'package:miniui/core/base/base_component.dart';

/// 卡片容器组件，用于包裹内容并应用统一的卡片样式，支持普通与玻璃态两种风格。
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
    final bool isGlass = miniIsGlassIOS(theme);

    final Widget content = Padding(
      padding: padding == EdgeInsets.zero
          ? EdgeInsets.all(theme.spacing.md)
          : padding,
      child: child,
    );

    return Padding(
      padding: margin,
      child: isGlass
          ? MiniGlassSurface(
              theme: theme,
              borderRadius: theme.radius.medium,
              backgroundColor:
                  theme.colors.background.withValues(alpha: 0.28),
              border: Border.all(
                color: theme.colors.foreground.withValues(alpha: 0.10),
              ),
              child: content,
            )
          : DecoratedBox(
              decoration: BoxDecoration(
                color: theme.colors.background,
                borderRadius: theme.radius.medium,
                border: Border.all(
                  color: theme.colors.foreground.withValues(alpha: 0.08),
                ),
              ),
              child: content,
            ),
    );
  }
}
