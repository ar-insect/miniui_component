import 'package:flutter/widgets.dart';
import 'package:miniui/miniui.dart';

/// Configuration for a single action sheet item (label, callback, destructive).
class MiniActionSheetAction {
  final String label;
  final VoidCallback? onPressed;
  final bool destructive;

  const MiniActionSheetAction({
    required this.label,
    this.onPressed,
    this.destructive = false,
  });
}

/// Bottom action sheet used to present a list of actions and a cancel button.
class MiniActionSheet extends BaseComponent {
  final String? title;
  final List<MiniActionSheetAction> actions;
  final String cancelLabel;

  const MiniActionSheet({
    super.key,
    this.title,
    required this.actions,
    this.cancelLabel = 'Cancel',
  });

  /// Push an action sheet route onto the navigation stack.
  static Future<void> show(
    BuildContext context, {
    String? title,
    required List<MiniActionSheetAction> actions,
    String cancelLabel = 'Cancel',
  }) {
    return Navigator.of(context).push<void>(
      PageRouteBuilder<void>(
        opaque: false,
        barrierDismissible: true,
        barrierColor: const Color(0x99000000),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              widthFactor: 1,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(animation),
                child: MiniActionSheet(
                  title: title,
                  actions: actions,
                  cancelLabel: cancelLabel,
                ),
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

    final List<Widget> children = <Widget>[];

    if (title != null && title!.isNotEmpty) {
      children.add(
        Padding(
          padding: EdgeInsets.all(theme.spacing.md),
          child: MiniText(
            title!,
            style: theme.typography.body.copyWith(
              color: theme.colors.foreground.withValues(alpha: 0.6),
            ),
          ),
        ),
      );
      children.add(const MiniDivider());
    }

    for (final MiniActionSheetAction action in actions) {
      children.add(
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.of(context).pop();
            action.onPressed?.call();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: theme.spacing.md,
              horizontal: theme.spacing.lg,
            ),
            child: MiniText(
              action.label,
              style: theme.typography.body.copyWith(
                color: action.destructive
                    ? theme.colors.danger
                    : theme.colors.foreground,
              ),
            ),
          ),
        ),
      );
      children.add(const MiniDivider());
    }

    return Padding(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          DecoratedBox(
            decoration: BoxDecoration(
              color: theme.colors.background,
              borderRadius: theme.radius.medium,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: children,
            ),
          ),
          SizedBox(height: theme.spacing.sm),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Navigator.of(context).pop();
            },
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: theme.colors.background,
                borderRadius: theme.radius.medium,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: theme.spacing.md,
                ),
                child: Center(
                  child: MiniText(
                    cancelLabel,
                    style: theme.typography.body.copyWith(
                      color: theme.colors.foreground,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
