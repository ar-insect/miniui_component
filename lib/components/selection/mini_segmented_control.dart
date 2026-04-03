import 'package:flutter/widgets.dart';
import 'package:miniui/components/text/mini_text.dart';
import 'package:miniui/core/base/base_component.dart';

class MiniSegment<T> {
  final T value;
  final String label;

  const MiniSegment({
    required this.value,
    required this.label,
  });
}

class MiniSegmentedControl<T> extends BaseComponent {
  final List<MiniSegment<T>> segments;
  final T? value;
  final ValueChanged<T>? onChanged;

  const MiniSegmentedControl({
    super.key,
    required this.segments,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = themeOf(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colors.background,
        borderRadius: theme.radius.pill,
        border: Border.all(
          color: theme.colors.foreground.withOpacity(0.12),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          for (int i = 0; i < segments.length; i++)
            _buildSegment(context, theme, segments[i], i == segments.length - 1),
        ],
      ),
    );
  }

  Widget _buildSegment(
    BuildContext context,
    MiniTheme theme,
    MiniSegment<T> segment,
    bool isLast,
  ) {
    final bool selected = segment.value == value;

    final Color bgColor =
        selected ? theme.colors.primary : theme.colors.background;
    final Color textColor =
        selected ? theme.colors.background : theme.colors.foreground;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onChanged == null ? null : () => onChanged!(segment.value),
        child: Container(
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius:
                isLast ? theme.radius.pill : const BorderRadius.horizontal(),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: theme.spacing.md,
            vertical: theme.spacing.xs,
          ),
          child: Center(
            child: MiniText(
              segment.label,
              style: theme.typography.small.copyWith(
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

