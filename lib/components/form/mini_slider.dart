import 'package:flutter/widgets.dart';
import 'package:miniui_component/core/base/base_component.dart';

class MiniSlider extends BaseComponent {
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  const MiniSlider({
    super.key,
    required this.value,
    this.min = 0,
    this.max = 1,
    required this.onChanged,
  }) : assert(max > min);

  void _updateValue(BuildContext context, Offset globalPosition) {
    final RenderBox box = context.findRenderObject()! as RenderBox;
    final Offset local = box.globalToLocal(globalPosition);
    final double ratio =
        (local.dx / box.size.width).clamp(0.0, 1.0);
    final double newValue = min + (max - min) * ratio;
    onChanged(newValue);
  }

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = themeOf(context);
    final double t = ((value - min) / (max - min)).clamp(0.0, 1.0);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanUpdate: (DragUpdateDetails details) {
        _updateValue(context, details.globalPosition);
      },
      onTapDown: (TapDownDetails details) {
        _updateValue(context, details.globalPosition);
      },
      child: SizedBox(
        height: theme.spacing.lg,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            Container(
              height: 3,
              decoration: BoxDecoration(
                color:
                    theme.colors.foreground.withValues(alpha: 0.08),
                borderRadius: theme.radius.small,
              ),
            ),
            FractionallySizedBox(
              widthFactor: t,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 3,
                  decoration: BoxDecoration(
                    color: theme.colors.primary,
                    borderRadius: theme.radius.small,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment(-1.0 + 2.0 * t, 0),
              child: Container(
                width: theme.spacing.md,
                height: theme.spacing.md,
                decoration: BoxDecoration(
                  color: theme.colors.background,
                  borderRadius: theme.radius.pill,
                  border: Border.all(
                    color: theme.colors.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

