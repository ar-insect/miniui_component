import 'package:flutter/widgets.dart';
import 'package:miniui/miniui.dart';

/// Simple confirmation dialog with optional title, message, confirm and
/// cancel buttons.
class MiniDialog extends BaseComponent {
  final String? title;
  final String message;
  final String confirmLabel;
  final String? cancelLabel;

  const MiniDialog({
    super.key,
    this.title,
    required this.message,
    this.confirmLabel = '确定',
    this.cancelLabel,
  });

  /// Show the dialog as a route and return the user's choice:
  /// - `true`: confirmed
  /// - `false`: cancelled
  /// - `null`: dismissed by tapping the barrier
  static Future<bool?> show(
    BuildContext context, {
    String? title,
    required String message,
    String confirmLabel = '确定',
    String? cancelLabel = '取消',
  }) {
    return Navigator.of(context).push<bool>(
      PageRouteBuilder<bool>(
        opaque: false,
        barrierDismissible: true,
        barrierColor: const Color(0x99000000),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: Center(
              child: MiniDialog(
                title: title,
                message: message,
                confirmLabel: confirmLabel,
                cancelLabel: cancelLabel,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = themeOf(context);

    final List<Widget> actions = <Widget>[];

    if (cancelLabel != null) {
      actions.add(
        Expanded(
          child: MiniButton(
            label: cancelLabel!,
            variant: MiniButtonVariant.ghost,
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
        ),
      );
    }

    actions.add(
      Expanded(
        child: MiniButton(
          label: confirmLabel,
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ),
    );

    return Padding(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.colors.background,
          borderRadius: theme.radius.medium,
        ),
        child: Padding(
          padding: EdgeInsets.all(theme.spacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (title != null && title!.isNotEmpty) ...<Widget>[
                MiniText(
                  title!,
                  style: theme.typography.title.copyWith(
                    color: theme.colors.foreground,
                  ),
                ),
                SizedBox(height: theme.spacing.sm),
              ],
              MiniText(
                message,
                style: theme.typography.body.copyWith(
                  color: theme.colors.foreground.withValues(alpha: 0.8),
                ),
              ),
              SizedBox(height: theme.spacing.lg),
              Row(
                children: actions,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
