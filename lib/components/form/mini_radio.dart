import 'package:flutter/widgets.dart';
import 'package:miniui/core/base/base_component.dart';

/// Radio component using a generic value to represent each option, supporting
/// optional label and disabled state.
class MiniRadio<T> extends BaseComponent {
  final T value;
  final T? groupValue;
  final ValueChanged<T>? onChanged;
  final String? label;
  final bool disabled;

  const MiniRadio({
    super.key,
    required this.value,
    required this.groupValue,
    this.onChanged,
    this.label,
    this.disabled = false,
  });

  bool get _selected => value == groupValue;

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = themeOf(context);
    final bool enabled = !disabled && onChanged != null;

    final Color borderColor = _selected
        ? theme.colors.primary
        : theme.colors.foreground.withValues(alpha: 0.3);

    final Widget circle = AnimatedOpacity(
      duration: const Duration(milliseconds: 120),
      opacity: disabled ? 0.5 : 1,
      child: Container(
        width: theme.spacing.lg,
        height: theme.spacing.lg,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: borderColor,
            width: 1.5,
          ),
        ),
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            width: _selected ? theme.spacing.sm : 0,
            height: _selected ? theme.spacing.sm : 0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _selected ? theme.colors.primary : borderColor,
            ),
          ),
        ),
      ),
    );

    void handleTap() {
      if (!enabled) {
        return;
      }
      onChanged!.call(value);
    }

    if (label == null || label!.isEmpty) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: handleTap,
        child: circle,
      );
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: handleTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          circle,
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
