import 'package:flutter/widgets.dart';
import 'package:miniui_component/miniui.dart';

class MiniSliverDemoPage extends StatelessWidget {
  static const String routeName = '/sliver-demo';

  const MiniSliverDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = MiniThemeProvider.of(context);

    return Container(
      color: theme.colors.background,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.all(theme.spacing.lg),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: theme.spacing.sm),
                      child: const MiniBackButton(),
                    ),
                    MiniText(
                      'Sliver list demo',
                      style: theme.typography.title.copyWith(
                        color: theme.colors.foreground,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: MiniDivider()),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return MiniListItem(
                  title: 'Sliver item ${index + 1}',
                  subtitle: 'Scrollable list built with CustomScrollView',
                  trailing: const MiniTag(label: 'View'),
                  onTap: () {
                    MiniToast.show(
                      context,
                      'Tapped sliver item ${index + 1}',
                    );
                  },
                );
              },
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
