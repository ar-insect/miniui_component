import 'package:flutter/widgets.dart';
import 'package:miniui/core/base/base_component.dart';

/// Mini 按钮的样式枚举，包含主按钮、幽灵按钮和危险按钮三种风格。
enum MiniButtonVariant {
  primary,
  ghost,
  danger,
}

/// 基础按钮组件，支持三种视觉风格和禁用态。
class MiniButton extends BaseComponent {
  final String label;
  final VoidCallback? onPressed;
  final MiniButtonVariant variant;
  final bool disabled;

  const MiniButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = MiniButtonVariant.primary,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = themeOf(context);
    final MiniButtonColors colors = _resolveColors(theme);

    return Opacity(
      opacity: disabled ? 0.5 : 1,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: disabled ? null : onPressed,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: colors.background,
            borderRadius: theme.radius.medium,
            border: Border.all(color: colors.border),
          ),
          child: Padding(
            padding: theme.componentSizes.buttonPadding,
            child: DefaultTextStyle(
              style: theme.typography.body.copyWith(
                color: colors.foreground,
                fontWeight: FontWeight.w500,
              ),
              child: Text(
                label,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 根据当前主题和按钮风格，计算按钮的背景色、前景色和边框色。
  MiniButtonColors _resolveColors(MiniTheme theme) {
    switch (variant) {
      case MiniButtonVariant.primary:
        return MiniButtonColors(
          background: theme.colors.primary,
          foreground: theme.colors.background,
          border: theme.colors.primary,
        );
      case MiniButtonVariant.ghost:
        return MiniButtonColors(
          background: theme.colors.background,
          foreground: theme.colors.primary,
          border: theme.colors.primary.withValues(alpha: 0.3),
        );
      case MiniButtonVariant.danger:
        return MiniButtonColors(
          background: theme.colors.danger,
          foreground: theme.colors.background,
          border: theme.colors.danger,
        );
    }
  }
}

/// 用于承载按钮的背景色、前景色和边框色配置。
class MiniButtonColors {
  final Color background;
  final Color foreground;
  final Color border;

  const MiniButtonColors({
    required this.background,
    required this.foreground,
    required this.border,
  });
}
