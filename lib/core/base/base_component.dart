import 'package:flutter/widgets.dart';
import 'package:miniui/core/utils/tokens.dart';

export 'package:miniui/core/utils/tokens.dart';

/// 主题控制器，负责保存当前主题并对外提供切换能力。
class MiniThemeController extends ChangeNotifier {
  MiniThemeController({
    MiniTheme? initialTheme,
    List<MiniTheme>? availableThemes,
  })  : _theme = initialTheme ?? MiniThemes.light,
        _availableThemes = availableThemes ?? MiniThemes.all;

  MiniTheme _theme;
  final List<MiniTheme> _availableThemes;

  /// 当前生效的主题。
  MiniTheme get theme => _theme;

  /// 当前可选的全部主题列表。
  List<MiniTheme> get availableThemes => List.unmodifiable(_availableThemes);

  /// 直接设置主题实例并通知所有监听者。
  void setTheme(MiniTheme theme) {
    if (identical(theme, _theme)) {
      return;
    }
    _theme = theme;
    notifyListeners();
  }

  /// 根据主题名称在可选主题中查找并切换主题。
  void setThemeByName(String name) {
    for (final MiniTheme theme in _availableThemes) {
      if (theme.name == name) {
        setTheme(theme);
        return;
      }
    }
  }

  /// 基于当前主题，按需替换 spacing / radius / typography 等 Token。
  ///
  /// 调用者可以先通过 [theme] 读取当前 Token，再使用 copyWith/自定义
  /// 数值构造新的 Token，并传入本方法完成整体更新。
  void updateTokens({
    MiniSpacingTokens? spacing,
    MiniRadiusTokens? radius,
    MiniTypographyTokens? typography,
  }) {
    final MiniTheme next = _theme.copyWith(
      spacing: spacing ?? _theme.spacing,
      radius: radius ?? _theme.radius,
      typography: typography ?? _theme.typography,
    );
    if (identical(next, _theme)) {
      return;
    }
    _theme = next;
    notifyListeners();
  }
}

/// 将 [MiniTheme] 注入到 Widget 树中的 InheritedWidget。
class MiniThemeProvider extends InheritedWidget {
  final MiniTheme theme;

  const MiniThemeProvider({
    super.key,
    required this.theme,
    required super.child,
  });

  /// 从上下文中读取当前的 [MiniTheme]。
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

/// 所有组件的基础类，提供统一的 [themeOf] 方法。
abstract class BaseComponent extends StatelessWidget {
  const BaseComponent({super.key});

  /// 从上下文中获取当前生效的主题。
  MiniTheme themeOf(BuildContext context) {
    return MiniThemeProvider.of(context);
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
