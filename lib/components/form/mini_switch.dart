import 'package:flutter/widgets.dart';
import 'package:miniui/core/base/base_component.dart';

/// 开关组件，用于在开/关两种状态之间切换，带动效与禁用态。
class MiniSwitch extends BaseComponent {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final bool disabled;

  const MiniSwitch({
    super.key,
    required this.value,
    this.onChanged,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = themeOf(context);
    final bool enabled = !disabled && onChanged != null;

    final Color trackColor = value
        ? theme.colors.primary.withValues(alpha: 0.9)
        : theme.colors.foreground.withValues(alpha: 0.18);

    final Color thumbColor =
        value ? theme.colors.background : theme.colors.background;

    final double width = theme.spacing.lg * 2.6;
    final double height = theme.spacing.md * 2.1;
    final double padding = theme.spacing.xs;
    final double thumbSize = height - padding * 2;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: enabled ? () => onChanged!.call(!value) : null,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 120),
        opacity: disabled ? 0.5 : 1,
        child: SizedBox(
          width: width,
          height: height,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                decoration: BoxDecoration(
                  color: trackColor,
                  borderRadius: theme.radius.pill,
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 160),
                curve: Curves.easeInOut,
                left: value ? width - thumbSize - padding : padding,
                top: padding,
                child: Container(
                  width: thumbSize,
                  height: thumbSize,
                  decoration: BoxDecoration(
                    color: thumbColor,
                    borderRadius: theme.radius.pill,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color:
                            theme.colors.foreground.withValues(alpha: 0.18),
                        blurRadius: 6,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
