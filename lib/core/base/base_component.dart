import 'package:flutter/widgets.dart';
import 'package:miniui/core/utils/tokens.dart';

export 'package:miniui/core/utils/tokens.dart';

/// Theme controller that stores the current [MiniTheme] and notifies listeners
/// when it changes.
class MiniThemeController extends ChangeNotifier {
  MiniThemeController({
    MiniTheme? initialTheme,
    List<MiniTheme>? availableThemes,
  })  : _theme = initialTheme ?? MiniThemes.light,
        _availableThemes = availableThemes ?? MiniThemes.all;

  MiniTheme _theme;
  final List<MiniTheme> _availableThemes;

  /// Currently active theme.
  MiniTheme get theme => _theme;

  /// All available themes that can be switched to.
  List<MiniTheme> get availableThemes => List.unmodifiable(_availableThemes);

  /// Set the theme instance directly and notify listeners if it changed.
  void setTheme(MiniTheme theme) {
    if (identical(theme, _theme)) {
      return;
    }
    _theme = theme;
    notifyListeners();
  }

  /// Find and switch theme by its [name] from the available theme list.
  void setThemeByName(String name) {
    for (final MiniTheme theme in _availableThemes) {
      if (theme.name == name) {
        setTheme(theme);
        return;
      }
    }
  }

  /// Update token groups (spacing / radius / typography / component sizes)
  /// based on the current theme.
  ///
  /// Callers usually read tokens from [theme], build new token objects via
  /// `copyWith` or custom constructors, and pass them here to update the theme.
  void updateTokens({
    MiniSpacingTokens? spacing,
    MiniRadiusTokens? radius,
    MiniTypographyTokens? typography,
    MiniComponentSizeTokens? componentSizes,
  }) {
    final MiniTheme next = _theme.copyWith(
      spacing: spacing ?? _theme.spacing,
      radius: radius ?? _theme.radius,
      typography: typography ?? _theme.typography,
      componentSizes: componentSizes ?? _theme.componentSizes,
    );
    if (identical(next, _theme)) {
      return;
    }
    _theme = next;
    notifyListeners();
  }
}

/// InheritedWidget that injects [MiniTheme] into the widget tree.
class MiniThemeProvider extends InheritedWidget {
  final MiniTheme theme;

  const MiniThemeProvider({
    super.key,
    required this.theme,
    required super.child,
  });

  /// Read current [MiniTheme] from the [BuildContext].
  static MiniTheme of(BuildContext context) {
    final MiniThemeProvider? provider =
        context.dependOnInheritedWidgetOfExactType<MiniThemeProvider>();
    assert(provider != null, 'MiniThemeProvider not found in context');
    return provider!.theme;
  }

  @override
  bool updateShouldNotify(MiniThemeProvider oldWidget) {
    return theme != oldWidget.theme;
  }
}

/// Base class for all components, exposing a shared [themeOf] helper.
abstract class BaseComponent extends StatelessWidget {
  const BaseComponent({super.key});

  /// Get the current active [MiniTheme] from [context].
  MiniTheme themeOf(BuildContext context) {
    return MiniThemeProvider.of(context);
  }
}

Future<void> miniShowOverlayEntry({
  required OverlayState overlay,
  required Duration duration,
  required WidgetBuilder builder,
}) async {
  final OverlayEntry entry = OverlayEntry(
    builder: builder,
  );

  overlay.insert(entry);

  await Future<void>.delayed(duration);

  if (entry.mounted) {
    entry.remove();
  }
}

class AnimatedMiniTheme extends ImplicitlyAnimatedWidget {
  final MiniTheme theme;
  final Widget child;

  const AnimatedMiniTheme({
    super.key,
    required this.theme,
    required this.child,
    required super.duration,
    super.curve,
    super.onEnd,
  });

  @override
  AnimatedWidgetBaseState<AnimatedMiniTheme> createState() =>
      _AnimatedMiniThemeState();
}

class _AnimatedMiniThemeState
    extends AnimatedWidgetBaseState<AnimatedMiniTheme> {
  MiniThemeTween? _themeTween;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _themeTween = visitor(
      _themeTween,
      widget.theme,
      (dynamic value) => MiniThemeTween(begin: value as MiniTheme),
    ) as MiniThemeTween?;
  }

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = _themeTween?.evaluate(animation) ?? widget.theme;
    return MiniThemeProvider(
      theme: theme,
      child: widget.child,
    );
  }
}

class MiniThemeTween extends Tween<MiniTheme> {
  MiniThemeTween({
    required super.begin,
    super.end,
  });

  @override
  MiniTheme lerp(double t) {
    return MiniTheme.lerp(begin!, end ?? begin!, t);
  }
}
