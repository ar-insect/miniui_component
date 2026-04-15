import 'package:flutter/widgets.dart';
import 'package:miniui_component/miniui.dart';

class MiniBottomNavDemoPage extends StatelessWidget {
  static const String routeName = '/bottom-nav-demo';

  const MiniBottomNavDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = MiniThemeProvider.of(context);

    return MiniBottomNavScaffold(
      items: <MiniBottomNavItem>[
        MiniBottomNavItem(
          icon: MiniIconPlaceholder(color: theme.colors.primary),
          label: '首页',
        ),
        MiniBottomNavItem(
          icon: MiniIconPlaceholder(color: theme.colors.accent),
          label: '收藏',
        ),
        MiniBottomNavItem(
          icon: MiniIconPlaceholder(color: theme.colors.foreground),
          label: '我的',
        ),
      ],
      pages: <Widget>[
        _buildHomeTab(theme),
        _buildFavoritesTab(theme),
        _buildProfileTab(theme),
      ],
    );
  }

  Widget _buildHomeTab(MiniTheme theme) {
    return Container(
      color: theme.colors.background,
      child: ListView(
        padding: EdgeInsets.all(theme.spacing.lg),
        children: <Widget>[
          const MiniSectionHeader(
            title: '首页',
            subtitle: 'Demo home tab',
          ),
          MiniCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                MiniText(
                  'This is the home tab.',
                  style: theme.typography.body.copyWith(
                    color: theme.colors.foreground,
                  ),
                ),
                SizedBox(height: theme.spacing.sm),
                MiniButton(
                  label: 'Show toast',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritesTab(MiniTheme theme) {
    return Container(
      color: theme.colors.background,
      child: ListView(
        padding: EdgeInsets.all(theme.spacing.lg),
        children: <Widget>[
          const MiniSectionHeader(
            title: '收藏',
            subtitle: 'Favorites tab content',
          ),
          const MiniEmpty(
            message: '还没有收藏任何内容',
          ),
        ],
      ),
    );
  }

  Widget _buildProfileTab(MiniTheme theme) {
    return Container(
      color: theme.colors.background,
      child: ListView(
        padding: EdgeInsets.all(theme.spacing.lg),
        children: const <Widget>[
          MiniSectionHeader(
            title: '我的',
            subtitle: 'Use MiniProfileDemoPage for full profile template',
          ),
        ],
      ),
    );
  }
}

class MiniIconPlaceholder extends StatelessWidget {
  final Color color;

  const MiniIconPlaceholder({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color.withValues(alpha: 0.12),
        border: Border.all(
          color: color.withValues(alpha: 0.4),
        ),
      ),
      child: Center(
        child: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: color,
          ),
        ),
      ),
    );
  }
}
