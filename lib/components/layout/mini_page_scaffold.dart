import 'package:flutter/widgets.dart';
import 'package:miniui/components/nav/mini_app_bar.dart';
import 'package:miniui/core/base/base_component.dart';

class MiniPageScaffold extends BaseComponent {
  final MiniAppBar? appBar;
  final Widget body;
  final Widget? bottomBar;
  final Color? backgroundColor;

  const MiniPageScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomBar,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = themeOf(context);

    return Container(
      color: backgroundColor ?? theme.colors.background,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (appBar != null) appBar!,
            Expanded(
              child: body,
            ),
            if (bottomBar != null) bottomBar!,
          ],
        ),
      ),
    );
  }
}

