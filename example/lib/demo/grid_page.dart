import 'package:flutter/widgets.dart';
import 'package:miniui_component/miniui.dart';

class MiniGridDemoPage extends StatelessWidget {
  static const String routeName = '/grid-demo';

  const MiniGridDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = MiniThemeProvider.of(context);

    return MiniPageScaffold(
      appBar: MiniAppBar(
        leading: const MiniBackButton(),
        title: const MiniText('Grid demo'),
        centerTitle: true,
      ),
      body: Container(
        color: theme.colors.background,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(theme.spacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const MiniSectionHeader(
                title: '3-column grid',
                subtitle: 'Ideal for feature shortcuts and small categories',
              ),
              MiniGrid(
                columns: 3,
                items: <MiniGridItem>[
                  MiniGridItem(
                    icon: MiniAvatar(
                      text: 'A',
                      size: 40,
                    ),
                    title: 'Album',
                    subtitle: 'Photos',
                    onTap: () {
                      MiniToast.show(context, 'Tapped Album');
                    },
                  ),
                  MiniGridItem(
                    icon: MiniAvatar(
                      text: 'B',
                      size: 40,
                    ),
                    title: 'Backup',
                    subtitle: 'Cloud',
                    onTap: () {
                      MiniToast.show(context, 'Tapped Backup');
                    },
                  ),
                  MiniGridItem(
                    icon: MiniAvatar(
                      text: 'C',
                      size: 40,
                    ),
                    title: 'Calendar',
                    subtitle: 'Schedule',
                    onTap: () {
                      MiniToast.show(context, 'Tapped Calendar');
                    },
                  ),
                  MiniGridItem(
                    icon: MiniAvatar(
                      text: 'D',
                      size: 40,
                    ),
                    title: 'Downloads',
                    subtitle: 'Files',
                    onTap: () {
                      MiniToast.show(context, 'Tapped Downloads');
                    },
                  ),
                  MiniGridItem(
                    icon: MiniAvatar(
                      text: 'E',
                      size: 40,
                    ),
                    title: 'Explore',
                    subtitle: 'Discover',
                    onTap: () {
                      MiniToast.show(context, 'Tapped Explore');
                    },
                  ),
                  MiniGridItem(
                    icon: MiniAvatar(
                      text: 'F',
                      size: 40,
                    ),
                    title: 'Favorites',
                    subtitle: 'Saved',
                    onTap: () {
                      MiniToast.show(context, 'Tapped Favorites');
                    },
                  ),
                ],
              ),
              SizedBox(height: theme.spacing.lg),
              const MiniSectionHeader(
                title: 'Responsive grid (max item width)',
                subtitle: 'Adapts columns based on available width',
              ),
              MiniGrid(
                maxItemWidth: 120,
                items: <MiniGridItem>[
                  MiniGridItem(
                    icon: MiniIconPlaceholder(
                      color: theme.colors.primary,
                    ),
                    title: 'Scan',
                    onTap: () {
                      MiniToast.show(context, 'Tapped Scan');
                    },
                  ),
                  MiniGridItem(
                    icon: MiniIconPlaceholder(
                      color: theme.colors.accent,
                    ),
                    title: 'Pay',
                    onTap: () {
                      MiniToast.show(context, 'Tapped Pay');
                    },
                  ),
                  MiniGridItem(
                    icon: MiniIconPlaceholder(
                      color: theme.colors.danger,
                    ),
                    title: 'Report',
                    onTap: () {
                      MiniToast.show(context, 'Tapped Report');
                    },
                  ),
                  MiniGridItem(
                    icon: MiniIconPlaceholder(
                      color: theme.colors.foreground,
                    ),
                    title: 'More',
                    onTap: () {
                      MiniToast.show(context, 'Tapped More');
                    },
                  ),
                ],
              ),
              SizedBox(height: theme.spacing.lg),
              const MiniSectionHeader(
                title: 'Horizontal cards',
                subtitle: 'Use childAspectRatio to get wide tiles',
              ),
              MiniGrid(
                columns: 2,
                childAspectRatio: 2.0,
                items: <MiniGridItem>[
                  MiniGridItem(
                    icon: MiniIconPlaceholder(
                      color: theme.colors.primary,
                    ),
                    titleWidget: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        MiniText(
                          'Pro plan',
                          style: theme.typography.small.copyWith(
                            color: theme.colors.foreground,
                          ),
                        ),
                        MiniTag(
                          label: 'New',
                          tone: MiniTagTone.success,
                        ),
                      ],
                    ),
                    subtitleWidget: MiniText(
                      'Unlock advanced analytics',
                      style: theme.typography.small.copyWith(
                        color: theme.colors.foreground
                            .withValues(alpha: 0.6),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {
                      MiniToast.show(context, 'Tapped Pro plan');
                    },
                  ),
                  MiniGridItem(
                    icon: MiniIconPlaceholder(
                      color: theme.colors.accent,
                    ),
                    titleWidget: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        MiniText(
                          'Team workspace',
                          style: theme.typography.small.copyWith(
                            color: theme.colors.foreground,
                          ),
                        ),
                        MiniTag(
                          label: '4 seats',
                          tone: MiniTagTone.neutral,
                        ),
                      ],
                    ),
                    subtitleWidget: MiniText(
                      'Collaborate with your team',
                      style: theme.typography.small.copyWith(
                        color: theme.colors.foreground
                            .withValues(alpha: 0.6),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {
                      MiniToast.show(context, 'Tapped Team workspace');
                    },
                  ),
                  MiniGridItem(
                    icon: MiniIconPlaceholder(
                      color: theme.colors.danger,
                    ),
                    titleWidget: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        MiniText(
                          'Security center',
                          style: theme.typography.small.copyWith(
                            color: theme.colors.foreground,
                          ),
                        ),
                        MiniTag(
                          label: '3 alerts',
                          tone: MiniTagTone.danger,
                        ),
                      ],
                    ),
                    subtitleWidget: MiniText(
                      'Monitor risk & alerts',
                      style: theme.typography.small.copyWith(
                        color: theme.colors.foreground
                            .withValues(alpha: 0.6),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {
                      MiniToast.show(context, 'Tapped Security center');
                    },
                  ),
                  MiniGridItem(
                    icon: MiniIconPlaceholder(
                      color: theme.colors.foreground,
                    ),
                    titleWidget: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        MiniText(
                          'Automation',
                          style: theme.typography.small.copyWith(
                            color: theme.colors.foreground,
                          ),
                        ),
                        MiniTag(
                          label: '5 flows',
                          tone: MiniTagTone.neutral,
                        ),
                      ],
                    ),
                    subtitleWidget: MiniText(
                      'Build custom workflows',
                      style: theme.typography.small.copyWith(
                        color: theme.colors.foreground
                            .withValues(alpha: 0.6),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {
                      MiniToast.show(context, 'Tapped Automation');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
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
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color.withValues(alpha: 0.08),
        border: Border.all(
          color: color.withValues(alpha: 0.4),
        ),
      ),
      child: Center(
        child: Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: color,
          ),
        ),
      ),
    );
  }
}
