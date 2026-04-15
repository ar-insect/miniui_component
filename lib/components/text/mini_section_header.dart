import 'package:flutter/widgets.dart';
import 'package:miniui_component/core/base/base_component.dart';
import 'package:miniui_component/components/text/mini_text.dart';

class MiniSectionHeader extends BaseComponent {
  final String title;
  final String? subtitle;
  final EdgeInsetsGeometry? padding;

  const MiniSectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = themeOf(context);

    final EdgeInsetsGeometry resolvedPadding = padding ??
        EdgeInsets.only(
          bottom: theme.spacing.sm,
        );

    return Padding(
      padding: resolvedPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MiniText(
            title,
            style: theme.typography.title.copyWith(
              color: theme.colors.foreground,
            ),
          ),
          if (subtitle != null && subtitle!.isNotEmpty) ...<Widget>[
            SizedBox(height: theme.spacing.xs),
            MiniText(
              subtitle!,
              style: theme.typography.small.copyWith(
                color:
                    theme.colors.foreground.withValues(alpha: 0.7),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
