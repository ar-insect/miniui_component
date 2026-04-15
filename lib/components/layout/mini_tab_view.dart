import 'package:flutter/widgets.dart';
import 'package:miniui_component/components/nav/mini_tab_bar.dart';
import 'package:miniui_component/core/base/base_component.dart';

class MiniTabView extends StatefulWidget {
  final List<MiniTabItem> tabs;
  final List<Widget> pages;
  final int initialIndex;
  final ValueChanged<int>? onIndexChanged;

  const MiniTabView({
    super.key,
    required this.tabs,
    required this.pages,
    this.initialIndex = 0,
    this.onIndexChanged,
  }) : assert(tabs.length == pages.length);

  @override
  State<MiniTabView> createState() => _MiniTabViewState();
}

class _MiniTabViewState extends State<MiniTabView> {
  late final PageController _pageController =
      PageController(initialPage: widget.initialIndex);
  late int _currentIndex = widget.initialIndex;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handleTabTap(int index) {
    if (index == _currentIndex) {
      return;
    }
    setState(() {
      _currentIndex = index;
    });
    widget.onIndexChanged?.call(index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeOutCubic,
    );
  }

  void _handlePageChanged(int index) {
    if (index == _currentIndex) {
      return;
    }
    setState(() {
      _currentIndex = index;
    });
    widget.onIndexChanged?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = MiniThemeProvider.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        MiniTabBar(
          items: widget.tabs,
          currentIndex: _currentIndex,
          onTap: _handleTabTap,
          isBottom: false,
        ),
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: _handlePageChanged,
            children: widget.pages,
          ),
        ),
      ],
    );
  }
}

