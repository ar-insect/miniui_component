import 'package:flutter/widgets.dart';
import 'package:miniui_component/core/base/base_component.dart';
import 'package:miniui_component/components/text/mini_text.dart';

class MiniBackButton extends BaseComponent {
  final VoidCallback? onPressed;
  final Color? color;
  final double? size;
  final double? iconSize;
  final Widget? icon;

  const MiniBackButton({
    super.key,
    this.onPressed,
    this.color,
    this.size,
    this.iconSize,
    this.icon,
  });

  void _handleTap(BuildContext context) {
    if (onPressed != null) {
      onPressed!();
      return;
    }
    Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = themeOf(context);

    final double resolvedSize = size ?? theme.spacing.lg * 2.0;
    final double resolvedIconSize = iconSize ?? 24;
    final Color resolvedColor = color ?? theme.colors.foreground;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _handleTap(context),
      child: SizedBox(
        width: resolvedSize,
        height: resolvedSize,
        child: Center(
          child: icon != null
              ? IconTheme(
                  data: IconThemeData(
                    color: resolvedColor,
                    size: resolvedIconSize,
                  ),
                  child: icon!,
                )
              : MiniText(
                  '‹',
                  style: theme.typography.title.copyWith(
                    fontSize: resolvedIconSize,
                    color: resolvedColor,
                  ),
                ),
        ),
      ),
    );
  }
}
