import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:miniui/core/base/base_component.dart';

/// Button variants: primary / ghost / danger.
enum MiniButtonVariant {
  primary,
  ghost,
  danger,
}

/// Core button component that supports three visual styles and disabled state.
class MiniButton extends BaseComponent {
  final String label;
  final VoidCallback? onPressed;
  final MiniButtonVariant variant;
  final bool disabled;
  final double elevation;
  final Color? hoverColor;
  final Color? splashColor;

  const MiniButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = MiniButtonVariant.primary,
    this.disabled = false,
    this.elevation = 2,
    this.hoverColor,
    this.splashColor,
  });

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = themeOf(context);
    final MiniButtonColors colors = _resolveColors(theme);

    return _MiniButtonBody(
      label: label,
      onPressed: onPressed,
      variant: variant,
      disabled: disabled,
      colors: colors,
      elevation: elevation,
      hoverColor: hoverColor,
      splashColor: splashColor,
    );
  }

  /// Resolve background / foreground / border colors from [theme] and [variant].
  MiniButtonColors _resolveColors(MiniTheme theme) {
    switch (variant) {
      case MiniButtonVariant.primary:
        return MiniButtonColors(
          background: theme.colors.primary,
          foreground: theme.colors.background,
          border: theme.colors.primary,
          borderWidth: 0,
        );
      case MiniButtonVariant.ghost:
        return MiniButtonColors(
          background: theme.colors.background,
          foreground: theme.colors.primary,
          border: theme.colors.primary.withValues(alpha: 0.4),
          borderWidth: 1.5,
        );
      case MiniButtonVariant.danger:
        return MiniButtonColors(
          background: theme.colors.danger,
          foreground: theme.colors.background,
          border: theme.colors.danger,
          borderWidth: 0,
        );
    }
  }
}

class _MiniButtonBody extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final MiniButtonVariant variant;
  final bool disabled;
  final MiniButtonColors colors;
  final double elevation;
  final Color? hoverColor;
  final Color? splashColor;

  const _MiniButtonBody({
    required this.label,
    this.onPressed,
    required this.variant,
    required this.disabled,
    required this.colors,
    required this.elevation,
    this.hoverColor,
    this.splashColor,
  });

  @override
  State<_MiniButtonBody> createState() => _MiniButtonBodyState();
}

class _MiniButtonBodyState extends State<_MiniButtonBody> {
  bool _pressed = false;
  bool _hovered = false;
  Timer? _pressResetTimer;

  void _handleTapDown(TapDownDetails details) {
    if (widget.disabled || widget.onPressed == null) {
      return;
    }
    // Immediately enter pressed state and cancel any existing reset timer.
    _pressResetTimer?.cancel();
    setState(() {
      _pressed = true;
    });
  }

  void _handleTapEnd() {
    if (widget.disabled || widget.onPressed == null) {
      return;
    }
    // Restore pressed state slightly after release to create a subtle
    // "bounce" feeling. Timer is used so it can be cancelled in [dispose],
    // avoiding pending timers during tests.
    _pressResetTimer?.cancel();
    _pressResetTimer = Timer(const Duration(milliseconds: 80), () {
      if (!mounted) {
        return;
      }
      setState(() {
        _pressed = false;
      });
    });
  }

  void _handleHover(bool value) {
    if (widget.disabled || widget.onPressed == null) {
      return;
    }
    if (_hovered == value) {
      return;
    }
    setState(() {
      _hovered = value;
    });
  }

  @override
  void dispose() {
    // Ensure timer is cancelled before the widget is disposed to avoid
    // setState being called after dispose.
    _pressResetTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = MiniThemeProvider.of(context);

    final bool interactive = !widget.disabled && widget.onPressed != null;

    Color background = widget.colors.background;

    if (interactive) {
      if (_pressed) {
        switch (widget.variant) {
          case MiniButtonVariant.primary:
          case MiniButtonVariant.danger:
            background = (widget.splashColor ??
                widget.colors.background.withValues(alpha: 0.85));
            break;
          case MiniButtonVariant.ghost:
            background = (widget.splashColor ??
                theme.colors.primary.withValues(alpha: 0.10));
            break;
        }
      } else if (_hovered) {
        switch (widget.variant) {
          case MiniButtonVariant.primary:
          case MiniButtonVariant.danger:
            background = (widget.hoverColor ??
                widget.colors.background.withValues(alpha: 0.92));
            break;
          case MiniButtonVariant.ghost:
            background = (widget.hoverColor ??
                theme.colors.primary.withValues(alpha: 0.06));
            break;
        }
      }
    }

    final Widget content = DefaultTextStyle(
      style: theme.typography.body.copyWith(
        color: widget.colors.foreground,
        fontWeight: FontWeight.w500,
      ),
      child: Text(
        widget.label,
        textAlign: TextAlign.center,
      ),
    );

    final Widget padded = Padding(
      padding: theme.componentSizes.buttonPadding,
      child: content,
    );

    final List<BoxShadow> shadows = <BoxShadow>[];
    if (interactive && widget.elevation > 0) {
      shadows.add(
        BoxShadow(
          color: theme.colors.foreground.withValues(alpha: 0.12),
          blurRadius: 4 + widget.elevation * 2,
          offset: const Offset(0, 2),
        ),
      );
    }

    final Widget decorated = AnimatedContainer(
      duration: const Duration(milliseconds: 160),
      decoration: BoxDecoration(
        color: background,
        borderRadius: theme.radius.medium,
        border: Border.all(
          color: widget.colors.border,
          width: widget.colors.borderWidth,
        ),
        boxShadow: shadows,
      ),
      child: padded,
    );

    final Widget body = Opacity(
      opacity: widget.disabled ? 0.5 : 1,
      child: decorated,
    );

    if (widget.onPressed == null || widget.disabled) {
      return body;
    }

    return MouseRegion(
      onEnter: (_) => _handleHover(true),
      onExit: (_) => _handleHover(false),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: _handleTapDown,
        onTapUp: (_) => _handleTapEnd(),
        onTapCancel: _handleTapEnd,
        onTap: widget.onPressed,
        child: body,
      ),
    );
  }
}

/// Helper container for button background / foreground / border colors.
class MiniButtonColors {
  final Color background;
  final Color foreground;
  final Color border;
  final double borderWidth;

  const MiniButtonColors({
    required this.background,
    required this.foreground,
    required this.border,
    this.borderWidth = 1,
  });
}
