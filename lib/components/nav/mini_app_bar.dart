import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:miniui/core/base/base_component.dart';

/// 顶部导航栏组件，支持左侧返回、标题居中和右侧操作区，兼容 Glass 风格。
class MiniAppBar extends BaseComponent {
  final Widget? leading;
  final Widget? title;
  final List<Widget> actions;
  final bool centerTitle;
  final double? height;

  const MiniAppBar({
    super.key,
    this.leading,
    this.title,
    this.actions = const <Widget>[],
    this.centerTitle = false,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = themeOf(context);
    final bool isGlass = miniIsGlassIOS(theme);
    final double barHeight =
        height ?? (isGlass ? 44 : theme.spacing.xl * 2);

    final Widget row = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        leading ?? SizedBox(width: theme.spacing.lg),
        Expanded(
          child: Align(
            alignment: centerTitle ? Alignment.center : Alignment.centerLeft,
            child: DefaultTextStyle(
              style: theme.typography.title.copyWith(
                color: theme.colors.foreground,
              ),
              child: title ?? const SizedBox.shrink(),
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: actions,
        ),
      ],
    );

    final Border border = Border(
      bottom: BorderSide(
        color: theme.colors.foreground
            .withValues(alpha: isGlass ? 0.08 : 0.06),
      ),
    );

    if (!isGlass) {
      return Container(
        height: barHeight,
        padding: EdgeInsets.symmetric(
          horizontal: theme.spacing.lg,
        ),
        decoration: BoxDecoration(
          color: theme.colors.background,
          border: border,
        ),
        child: row,
      );
    }

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 30,
          sigmaY: 30,
        ),
        child: Container(
          height: barHeight,
          padding: EdgeInsets.symmetric(
            horizontal: theme.spacing.lg,
          ),
          decoration: BoxDecoration(
            color: theme.colors.background.withValues(alpha: 0.24),
            border: border,
          ),
          child: row,
        ),
      ),
    );
  }
}
