import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:miniui/miniui.dart';
import 'demo/custom_tokens_page.dart';
import 'demo/home_page.dart';
import 'demo/list_page.dart';
import 'demo/tokens_page.dart';
import 'demo/layout_page.dart';
import 'demo/feedback_page.dart';

void main() {
  final MiniThemeController controller = MiniThemeController();
  runApp(MiniUiApp(controller: controller));
}

class MiniUiApp extends StatefulWidget {
  final MiniThemeController controller;

  const MiniUiApp({
    super.key,
    required this.controller,
  });

  @override
  State<MiniUiApp> createState() => _MiniUiAppState();
}

class _MiniUiAppState extends State<MiniUiApp> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_handleThemeChanged);
  }

  @override
  void didUpdateWidget(covariant MiniUiApp oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_handleThemeChanged);
      widget.controller.addListener(_handleThemeChanged);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleThemeChanged);
    super.dispose();
  }

  void _handleThemeChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = widget.controller.theme;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: AnimatedMiniTheme(
        theme: theme,
        duration: const Duration(milliseconds: 220),
        child: WidgetsApp(
          color: theme.colors.background,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: (RouteSettings settings) {
            Widget page;
            switch (settings.name) {
              case MiniListDemoPage.routeName:
                page = const MiniListDemoPage();
                break;
              case MiniTokensPage.routeName:
                page = const MiniTokensPage();
                break;
              case MiniLayoutDemoPage.routeName:
                page = const MiniLayoutDemoPage();
                break;
              case MiniFeedbackDemoPage.routeName:
                page = const MiniFeedbackDemoPage();
                break;
              case MiniCustomTokensPage.routeName:
                page = MiniCustomTokensPage(
                  controller: widget.controller,
                );
                break;
              case '/':
              default:
                page = MiniHomePage(
                  controller: widget.controller,
                );
            }
            if (defaultTargetPlatform == TargetPlatform.iOS) {
              return CupertinoPageRoute<void>(
                settings: settings,
                builder: (BuildContext context) => page,
              );
            }

            return PageRouteBuilder<void>(
              settings: settings,
              pageBuilder: (
                BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
              ) {
                return page;
              },
              transitionsBuilder: (
                BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child,
              ) {
                final Size size = MediaQuery.of(context).size;

                final Animation<double> curvedAnimation = CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOutCubic,
                  reverseCurve: Curves.easeInCubic,
                );

                final Tween<Offset> slideTween = Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                );

                final Offset offset = slideTween.evaluate(curvedAnimation);

                return Transform.translate(
                  offset: Offset(offset.dx * size.width, 0),
                  child: child,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
