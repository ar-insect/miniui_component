import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:miniui/core/base/base_component.dart';

/// Lightweight bottom toast component.
class MiniToast extends BaseComponent {
  final String message;

  const MiniToast({
    super.key,
    required this.message,
  });

  /// Show a toast at the bottom of the page using [Overlay].
  static Future<void> show(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
  }) async {
    final OverlayState? overlay = Overlay.of(context);
    if (overlay == null) {
      return;
    }

    final MiniTheme theme = MiniThemeProvider.of(context);

    await miniShowOverlayEntry(
      overlay: overlay,
      duration: duration,
      builder: (BuildContext overlayContext) {
        return Positioned.fill(
          child: IgnorePointer(
            child: SafeArea(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: theme.spacing.xl),
                  child: MiniToast(message: message),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = themeOf(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colors.foreground.withValues(alpha: 0.9),
        borderRadius: theme.radius.medium,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: theme.spacing.lg,
          vertical: theme.spacing.sm,
        ),
        child: DefaultTextStyle(
          style: theme.typography.body.copyWith(
            color: theme.colors.background,
          ),
          child: Text(
            message,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
