import 'package:flutter/widgets.dart';
import 'package:miniui/components/text/mini_text.dart';
import 'package:miniui/core/base/base_component.dart';

/// SegmentedControl 的单个段配置，包含值与显示文案。
class MiniSegment<T> {
  final T value;
  final String label;

  const MiniSegment({
    required this.value,
    required this.label,
  });
}

/// 分段控制组件，适合用于少量离散选项的切换。
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
        borderRadius: theme.radius.medium,
        border: Border.all(
          color: theme.colors.foreground.withValues(alpha: 0.12),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          for (int i = 0; i < segments.length; i++)
            _buildSegment(context, theme, segments[i], i, segments.length),
        ],
      ),
    );
  }

  Widget _buildSegment(
    BuildContext context,
    MiniTheme theme,
    MiniSegment<T> segment,
    int index,
    int total,
  ) {
    final bool selected = segment.value == value;

    final Color bgColor =
        selected ? theme.colors.primary : theme.colors.background;
    final Color textColor =
        selected ? theme.colors.background : theme.colors.foreground;

    BorderRadius radius;
    if (total == 1) {
      radius = theme.radius.medium;
    } else if (index == 0) {
      radius = BorderRadius.only(
        topLeft: theme.radius.medium.topLeft,
        bottomLeft: theme.radius.medium.bottomLeft,
      );
    } else if (index == total - 1) {
      radius = BorderRadius.only(
        topRight: theme.radius.medium.topRight,
        bottomRight: theme.radius.medium.bottomRight,
      );
    } else {
      radius = BorderRadius.zero;
    }

    final Widget label = MiniText(
      segment.label,
      style: theme.typography.small.copyWith(
        color: textColor,
      ),
    );

    final Widget content = Center(child: label);

    final Widget segmentBody = Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: radius,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: theme.spacing.md,
        vertical: theme.spacing.xs,
      ),
      child: content,
    );

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onChanged == null ? null : () => onChanged!(segment.value),
        child: segmentBody,
      ),
    );
  }
}
