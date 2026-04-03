import 'package:flutter/widgets.dart';
import 'package:miniui/core/base/base_component.dart';

class MiniStepper extends BaseComponent {
  final int value;
  final int min;
  final int max;
  final ValueChanged<int>? onChanged;

  const MiniStepper({
    super.key,
    required this.value,
    this.min = 0,
    this.max = 9999,
    this.onChanged,
  });

  bool get _canDecrement => value > min;
  bool get _canIncrement => value < max;

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = themeOf(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _buildButton(
          context,
          theme,
          '-',
          enabled: _canDecrement && onChanged != null,
          onTap: () {
            if (_canDecrement && onChanged != null) {
              onChanged!(value - 1);
            }
          },
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: theme.spacing.md,
          ),
          child: Text(
            '$value',
            style: theme.typography.body.copyWith(
              color: theme.colors.foreground,
            ),
          ),
        ),
        _buildButton(
          context,
          theme,
          '+',
          enabled: _canIncrement && onChanged != null,
          onTap: () {
            if (_canIncrement && onChanged != null) {
              onChanged!(value + 1);
            }
          },
        ),
      ],
    );
  }

  Widget _buildButton(
    BuildContext context,
    MiniTheme theme,
    String label, {
    required bool enabled,
    required VoidCallback onTap,
  }) {
    return Opacity(
      opacity: enabled ? 1 : 0.4,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: enabled ? onTap : null,
        child: Container(
          width: theme.spacing.lg * 1.5,
          height: theme.spacing.lg * 1.5,
          decoration: BoxDecoration(
            color: theme.colors.background,
            borderRadius: theme.radius.small,
            border: Border.all(
              color: theme.colors.foreground.withOpacity(0.2),
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: theme.typography.body.copyWith(
                color: theme.colors.foreground,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

