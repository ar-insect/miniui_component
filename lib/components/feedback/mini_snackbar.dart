import 'package:flutter/widgets.dart';
import 'package:miniui/miniui.dart';

class MiniSnackbar extends BaseComponent {
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  const MiniSnackbar({
    super.key,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  static Future<void> show(
    BuildContext context,
    String message, {
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 3),
  }) async {
    final OverlayState? overlay = Overlay.of(context);
    if (overlay == null) {
      return;
    }

    final MiniTheme theme = MiniThemeProvider.of(context);

    final OverlayEntry entry = OverlayEntry(
      builder: (BuildContext overlayContext) {
        return Positioned(
          left: theme.spacing.lg,
          right: theme.spacing.lg,
          bottom: theme.spacing.lg,
          child: MiniSnackbar(
            message: message,
            actionLabel: actionLabel,
            onAction: onAction,
          ),
        );
      },
    );

    overlay.insert(entry);

    await Future<void>.delayed(duration);

    if (entry.mounted) {
      entry.remove();
    }
  }

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = themeOf(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colors.foreground.withOpacity(0.9),
        borderRadius: theme.radius.medium,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: theme.spacing.lg,
          vertical: theme.spacing.sm,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: MiniText(
                message,
                style: theme.typography.body.copyWith(
                  color: theme.colors.background,
                ),
              ),
            ),
            if (actionLabel != null && onAction != null) ...<Widget>[
              SizedBox(width: theme.spacing.lg),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onAction,
                child: MiniText(
                  actionLabel!,
                  style: theme.typography.body.copyWith(
                    color: theme.colors.accent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

