import 'package:flutter/widgets.dart';
import 'package:miniui_component/core/base/base_component.dart';
import 'package:miniui_component/components/text/mini_text.dart';
import 'package:miniui_component/components/button/mini_button.dart';

enum MiniResultStatus {
  success,
  error,
  warning,
  empty,
}

class MiniResult extends BaseComponent {
  final MiniResultStatus status;
  final String title;
  final String? description;
  final Widget? icon;
  final String? primaryActionLabel;
  final VoidCallback? onPrimaryAction;
  final String? secondaryActionLabel;
  final VoidCallback? onSecondaryAction;

  const MiniResult({
    super.key,
    required this.status,
    required this.title,
    this.description,
    this.icon,
    this.primaryActionLabel,
    this.onPrimaryAction,
    this.secondaryActionLabel,
    this.onSecondaryAction,
  });

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = themeOf(context);

    Color baseColor;
    switch (status) {
      case MiniResultStatus.success:
        baseColor = theme.colors.primary;
        break;
      case MiniResultStatus.error:
        baseColor = theme.colors.danger;
        break;
      case MiniResultStatus.warning:
        baseColor = theme.colors.accent;
        break;
      case MiniResultStatus.empty:
        baseColor = theme.colors.foreground.withValues(alpha: 0.3);
        break;
    }

    final Widget resolvedIcon = icon ??
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: baseColor.withValues(alpha: 0.12),
          ),
          child: Center(
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: baseColor,
              ),
            ),
          ),
        );

    final List<Widget> children = <Widget>[
      resolvedIcon,
      SizedBox(height: theme.spacing.lg),
      MiniText(
        title,
        style: theme.typography.heading.copyWith(
          color: theme.colors.foreground,
        ),
        textAlign: TextAlign.center,
      ),
    ];

    if (description != null && description!.isNotEmpty) {
      children.add(SizedBox(height: theme.spacing.sm));
      children.add(
        MiniText(
          description!,
          style: theme.typography.body.copyWith(
            color: theme.colors.foreground.withValues(alpha: 0.7),
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    final bool hasPrimary =
        primaryActionLabel != null && onPrimaryAction != null;
    final bool hasSecondary =
        secondaryActionLabel != null && onSecondaryAction != null;

    if (hasPrimary || hasSecondary) {
      children.add(SizedBox(height: theme.spacing.lg));
      children.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (hasSecondary)
              SizedBox(
                width: 140,
                child: MiniButton(
                  label: secondaryActionLabel!,
                  variant: MiniButtonVariant.ghost,
                  onPressed: onSecondaryAction,
                ),
              ),
            if (hasSecondary && hasPrimary)
              SizedBox(width: theme.spacing.sm),
            if (hasPrimary)
              SizedBox(
                width: 140,
                child: MiniButton(
                  label: primaryActionLabel!,
                  onPressed: onPrimaryAction,
                ),
              ),
          ],
        ),
      );
    }

    return Center(
      child: Padding(
        padding: EdgeInsets.all(theme.spacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: children,
        ),
      ),
    );
  }
}
