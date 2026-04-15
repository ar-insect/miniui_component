import 'package:flutter/widgets.dart';
import 'package:miniui_component/core/base/base_component.dart';
import 'package:miniui_component/components/text/mini_text.dart';

class MiniBottomNavItem {
  final Widget icon;
  final String label;

  const MiniBottomNavItem({
    required this.icon,
    required this.label,
  });
}

class MiniBottomNavScaffold extends StatefulWidget {
  final List<MiniBottomNavItem> items;
  final List<Widget> pages;
  final int initialIndex;

  const MiniBottomNavScaffold({
    super.key,
    required this.items,
    required this.pages,
    this.initialIndex = 0,
  }) : assert(items.length == pages.length);

  @override
  State<MiniBottomNavScaffold> createState() =>
      _MiniBottomNavScaffoldState();
}

class _MiniBottomNavScaffoldState extends State<MiniBottomNavScaffold> {
  late int _currentIndex = widget.initialIndex;

  void _handleTap(int index) {
    if (index == _currentIndex) {
      return;
    }
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = MiniThemeProvider.of(context);

    return Container(
      color: theme.colors.background,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: IndexedStack(
                index: _currentIndex,
                children: widget.pages,
              ),
            ),
            _MiniBottomBar(
              items: widget.items,
              currentIndex: _currentIndex,
              onTap: _handleTap,
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniBottomBar extends StatelessWidget {
  final List<MiniBottomNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _MiniBottomBar({
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = MiniThemeProvider.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colors.background,
        border: Border(
          top: BorderSide(
            color: theme.colors.foreground.withValues(alpha: 0.06),
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: theme.spacing.lg,
        vertical: theme.spacing.sm,
      ),
      child: Row(
        children: List<Widget>.generate(items.length, (int index) {
          final bool selected = index == currentIndex;
          final Color iconColor = selected
              ? theme.colors.primary
              : theme.colors.foreground.withValues(alpha: 0.6);
          final Color labelColor = selected
              ? theme.colors.primary
              : theme.colors.foreground.withValues(alpha: 0.7);

          return Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onTap(index),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconTheme(
                    data: IconThemeData(color: iconColor),
                    child: items[index].icon,
                  ),
                  SizedBox(height: theme.spacing.xs),
                  MiniText(
                    items[index].label,
                    style: theme.typography.small.copyWith(
                      color: labelColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
