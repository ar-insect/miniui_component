import 'package:flutter/widgets.dart';
import 'package:miniui/core/base/base_component.dart';

class MiniCarousel extends StatefulWidget {
  final List<Widget> items;
  final double height;
  final EdgeInsetsGeometry padding;

  const MiniCarousel({
    super.key,
    required this.items,
    required this.height,
    this.padding = EdgeInsets.zero,
  });

  @override
  State<MiniCarousel> createState() => _MiniCarouselState();
}

class _MiniCarouselState extends State<MiniCarousel> {
  late final PageController _controller = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = MiniThemeProvider.of(context);

    if (widget.items.isEmpty) {
      return const SizedBox.shrink();
    }

    final Widget pager = SizedBox(
      height: widget.height,
      child: PageView.builder(
        controller: _controller,
        itemCount: widget.items.length,
        onPageChanged: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (BuildContext context, int index) {
          return SizedBox.expand(
            child: widget.items[index],
          );
        },
      ),
    );

    final Widget indicator = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        for (int i = 0; i < widget.items.length; i++)
          Container(
            width: 6,
            height: 6,
            margin: EdgeInsets.only(
              left: i == 0 ? 0 : theme.spacing.xs,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: i == _currentIndex
                  ? theme.colors.primary
                  : theme.colors.foreground.withValues(alpha: 0.18),
            ),
          ),
      ],
    );

    final EdgeInsetsGeometry resolvedPadding = widget.padding == EdgeInsets.zero
        ? EdgeInsets.zero
        : widget.padding;

    return Padding(
      padding: resolvedPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          pager,
          SizedBox(height: theme.spacing.xs),
          indicator,
        ],
      ),
    );
  }
}
