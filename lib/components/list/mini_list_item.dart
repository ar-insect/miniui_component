import 'package:flutter/widgets.dart';
import 'package:miniui/core/base/base_component.dart';

/// 列表项组件，支持前置图标、标题、副标题和右侧附加内容。
class MiniListItem extends BaseComponent {
  final Widget? leading;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final bool showArrow;

  const MiniListItem({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.padding,
    this.showArrow = false,
  });

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = themeOf(context);
    return _MiniListItemBody(
      theme: theme,
      leading: leading,
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      onTap: onTap,
      padding: padding,
      showArrow: showArrow,
    );
  }
}

class _MiniListItemBody extends StatefulWidget {
  final MiniTheme theme;
  final Widget? leading;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final bool showArrow;

  const _MiniListItemBody({
    required this.theme,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.padding,
    required this.showArrow,
  });

  @override
  State<_MiniListItemBody> createState() => _MiniListItemBodyState();
}

class _MiniListItemBodyState extends State<_MiniListItemBody> {
  bool _pressed = false;

  void _handleTapDown(TapDownDetails details) {
    if (widget.onTap == null) {
      return;
    }
    setState(() {
      _pressed = true;
    });
  }

  void _handleTapEnd() {
    if (widget.onTap == null) {
      return;
    }
    setState(() {
      _pressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = widget.theme;

    final EdgeInsetsGeometry resolvedPadding = widget.padding ??
        EdgeInsets.symmetric(
          horizontal: theme.spacing.lg,
          vertical: theme.spacing.md,
        );

    final Widget titleWidget = Text(
      widget.title,
      style: theme.typography.body.copyWith(
        color: theme.colors.foreground,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );

    final Widget? subtitleWidget = widget.subtitle == null
        ? null
        : Text(
            widget.subtitle!,
            style: theme.typography.small.copyWith(
              color: theme.colors.foreground.withValues(alpha: 0.6),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          );

    final List<Widget> rowChildren = <Widget>[];

    if (widget.leading != null) {
      rowChildren.add(Padding(
        padding: EdgeInsets.only(right: theme.spacing.md),
        child: widget.leading!,
      ));
    }

    rowChildren.add(
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            titleWidget,
            if (subtitleWidget != null) ...<Widget>[
              SizedBox(height: theme.spacing.xs),
              subtitleWidget,
            ],
          ],
        ),
      ),
    );

    if (widget.trailing != null) {
      rowChildren.add(Padding(
        padding: EdgeInsets.only(left: theme.spacing.md),
        child: Align(
          alignment: Alignment.centerRight,
          child: widget.trailing!,
        ),
      ));
    }

    if (widget.showArrow) {
      rowChildren.add(
        Padding(
          padding: EdgeInsets.only(left: theme.spacing.md),
          child: Text(
            '›',
            style: theme.typography.body.copyWith(
              color: theme.colors.foreground.withValues(alpha: 0.25),
            ),
          ),
        ),
      );
    }

    final Widget content = Padding(
      padding: resolvedPadding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: rowChildren,
      ),
    );

    final Color baseColor = theme.colors.background;
    final Color pressedColor =
        theme.colors.foreground.withValues(alpha: 0.04);

    final Widget container = AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      color: _pressed ? pressedColor : baseColor,
      child: content,
    );

    if (widget.onTap == null) {
      return container;
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: _handleTapDown,
      onTapUp: (_) => _handleTapEnd(),
      onTapCancel: _handleTapEnd,
      onTap: widget.onTap,
      child: container,
    );
  }
}
