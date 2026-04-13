import 'package:flutter/widgets.dart';
import 'package:miniui/core/base/base_component.dart';

/// Checkbox component with optional label and disabled state, following
/// theme colors.
class MiniCheckbox extends BaseComponent {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final String? label;
  final bool disabled;

  const MiniCheckbox({
    super.key,
    required this.value,
    this.onChanged,
    this.label,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = themeOf(context);
    final bool enabled = !disabled && onChanged != null;

    final Color borderColor = value
        ? theme.colors.primary
        : theme.colors.foreground.withValues(alpha: 0.3);

    final Color backgroundColor = value
        ? theme.colors.primary
        : theme.colors.background;

    final Widget box = AnimatedOpacity(
      duration: const Duration(milliseconds: 120),
      opacity: disabled ? 0.5 : 1,
      child: Container(
        width: theme.spacing.lg,
        height: theme.spacing.lg,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: theme.radius.small,
          border: Border.all(
            color: borderColor,
            width: 1.5,
          ),
        ),
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            width: value ? theme.spacing.sm : 0,
            height: value ? theme.spacing.sm : 0,
            decoration: BoxDecoration(
              borderRadius: theme.radius.small,
              color: value ? theme.colors.background : backgroundColor,
            ),
          ),
        ),
      ),
    );

    if (label == null || label!.isEmpty) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: enabled ? () => onChanged!.call(!value) : null,
        child: box,
      );
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: enabled ? () => onChanged!.call(!value) : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          box,
          SizedBox(width: theme.spacing.sm),
          DefaultTextStyle(
            style: theme.typography.body.copyWith(
              color: theme.colors.foreground.withValues(
                alpha: disabled ? 0.4 : 0.8,
              ),
            ),
            child: Text(label!),
          ),
        ],
      ),
    );
  }
}
