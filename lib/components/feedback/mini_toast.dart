import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:miniui/core/base/base_component.dart';

/// 轻量级底部 Toast 提示组件。
class MiniToast extends BaseComponent {
  final String message;

  const MiniToast({
    super.key,
    required this.message,
  });

  /// 以 Overlay 的方式在页面底部显示一条 Toast。
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
