import 'package:flutter/widgets.dart';
import 'package:miniui_component/miniui.dart';

class MiniProfileDemoPage extends StatefulWidget {
  static const String routeName = '/profile-demo';

  const MiniProfileDemoPage({super.key});

  @override
  State<MiniProfileDemoPage> createState() => _MiniProfileDemoPageState();
}

class _MiniProfileDemoPageState extends State<MiniProfileDemoPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

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
  }

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = MiniThemeProvider.of(context);

    return MiniPageScaffold(
      appBar: MiniAppBar(
        leading: const MiniBackButton(),
        title: const MiniText('Profile template'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          MiniTabBar(
            items: const <MiniTabItem>[
              MiniTabItem(label: '概览'),
              MiniTabItem(label: '订单'),
              MiniTabItem(label: '推荐'),
            ],
            currentIndex: _currentIndex,
            onTap: _handleTabTap,
            isBottom: false,
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: _handlePageChanged,
              children: <Widget>[
                _buildOverviewTab(theme),
                _buildOrdersTab(theme),
                _buildFeedTab(theme),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewTab(MiniTheme theme) {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        _buildGradientHeader(theme),
        SizedBox(height: theme.spacing.lg),
        _buildVipBenefitsCard(theme),
        SizedBox(height: theme.spacing.lg),
        _buildOrderGridCard(theme),
        SizedBox(height: theme.spacing.lg),
        _buildQuickToolsCard(theme),
        SizedBox(height: theme.spacing.lg),
      ],
    );
  }

  Widget _buildGradientHeader(MiniTheme theme) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        theme.spacing.lg,
        theme.spacing.lg * 1.5,
        theme.spacing.lg,
        theme.spacing.lg,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            theme.colors.primary.withValues(alpha: 0.9),
            theme.colors.primary.withValues(alpha: 0.6),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: theme.radius.large.topLeft,
          bottomRight: theme.radius.large.topRight,
        ),
      ),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: Container(
              width: 56,
              height: 56,
              color: theme.colors.background.withValues(alpha: 0.1),
              child: const Center(
                child: MiniText('U'),
              ),
            ),
          ),
          SizedBox(width: theme.spacing.md),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              MiniText(
                'MiniUi 用户',
                style: theme.typography.title.copyWith(
                  color: theme.colors.background,
                ),
              ),
              SizedBox(height: theme.spacing.xs),
              MiniText(
                'V 值 280 · 超级会员',
                style: theme.typography.small.copyWith(
                  color: theme.colors.background.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVipBenefitsCard(MiniTheme theme) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: theme.spacing.lg),
      child: MiniCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MiniGrid(
              columns: 3,
              childAspectRatio: 0.9,
              items: <MiniGridItem>[
                MiniGridItem(
                  icon: MiniIconPlaceholder(
                    color: theme.colors.primary,
                  ),
                  titleWidget: Wrap(
                    spacing: theme.spacing.xs,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: <Widget>[
                      MiniText(
                        '开通超会',
                        style: theme.typography.small.copyWith(
                          color: theme.colors.foreground,
                        ),
                      ),
                      MiniTag(
                        label: '立减 ¥40',
                        tone: MiniTagTone.success,
                      ),
                    ],
                  ),
                  subtitleWidget: MiniText(
                    '预付年费享折扣',
                    style: theme.typography.small.copyWith(
                      color: theme.colors.foreground
                          .withValues(alpha: 0.7),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                MiniGridItem(
                  icon: MiniIconPlaceholder(
                    color: theme.colors.accent,
                  ),
                  titleWidget: MiniText(
                    '免邮权益',
                    style: theme.typography.small.copyWith(
                      color: theme.colors.foreground,
                    ),
                  ),
                  subtitleWidget: MiniText(
                    '退换货更安心',
                    style: theme.typography.small.copyWith(
                      color: theme.colors.foreground
                          .withValues(alpha: 0.7),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                MiniGridItem(
                  icon: MiniIconPlaceholder(
                    color: theme.colors.danger,
                  ),
                  titleWidget: MiniText(
                    '专属客服',
                    style: theme.typography.small.copyWith(
                      color: theme.colors.foreground,
                    ),
                  ),
                  subtitleWidget: MiniText(
                    '优先解答问题',
                    style: theme.typography.small.copyWith(
                      color: theme.colors.foreground
                          .withValues(alpha: 0.7),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderGridCard(MiniTheme theme) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const MiniSectionHeader(
            title: '订单与服务',
            subtitle: '常用订单入口和服务功能',
          ),
          MiniCard(
            child: MiniGrid(
              columns: 5,
              childAspectRatio: 0.9,
              items: <MiniGridItem>[
                MiniGridItem(
                  icon: const MiniIconPlaceholder(
                    color: Color(0xFFFE9C6A),
                  ),
                  title: '待付款',
                  onTap: () {
                    MiniToast.show(context, 'Tapped 待付款');
                  },
                ),
                MiniGridItem(
                  icon: const MiniIconPlaceholder(
                    color: Color(0xFF59A4FF),
                  ),
                  title: '待收货',
                  onTap: () {
                    MiniToast.show(context, 'Tapped 待收货');
                  },
                ),
                MiniGridItem(
                  icon: const MiniIconPlaceholder(
                    color: Color(0xFFFF7EB3),
                  ),
                  title: '待评价',
                  onTap: () {
                    MiniToast.show(context, 'Tapped 待评价');
                  },
                ),
                MiniGridItem(
                  icon: const MiniIconPlaceholder(
                    color: Color(0xFF4BD4C6),
                  ),
                  title: '退换/售后',
                  onTap: () {
                    MiniToast.show(context, 'Tapped 退换/售后');
                  },
                ),
                MiniGridItem(
                  icon: MiniIconPlaceholder(
                    color: theme.colors.foreground,
                  ),
                  title: '全部订单',
                  onTap: () {
                    MiniToast.show(context, 'Tapped 全部订单');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickToolsCard(MiniTheme theme) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const MiniSectionHeader(
            title: '快捷工具',
            subtitle: '只展示图标的紧凑宫格',
          ),
          MiniCard(
            child: MiniGrid(
              columns: 4,
              childAspectRatio: 1,
              items: <MiniGridItem>[
                MiniGridItem(
                  icon: MiniIconPlaceholder(
                    color: theme.colors.primary,
                  ),
                  onTap: () {
                    MiniToast.show(context, 'Tapped 领券中心');
                  },
                ),
                MiniGridItem(
                  icon: MiniIconPlaceholder(
                    color: theme.colors.accent,
                  ),
                  onTap: () {
                    MiniToast.show(context, 'Tapped 收藏夹');
                  },
                ),
                MiniGridItem(
                  icon: MiniIconPlaceholder(
                    color: theme.colors.danger,
                  ),
                  onTap: () {
                    MiniToast.show(context, 'Tapped 足迹');
                  },
                ),
                MiniGridItem(
                  icon: MiniIconPlaceholder(
                    color: theme.colors.foreground,
                  ),
                  onTap: () {
                    MiniToast.show(context, 'Tapped 钱包');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersTab(MiniTheme theme) {
    return ListView(
      padding: EdgeInsets.all(theme.spacing.lg),
      children: <Widget>[
        const MiniSectionHeader(
          title: '最近订单',
          subtitle: 'Use MiniCard + MiniImage + MiniTag to build order cards',
        ),
        MiniCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: theme.radius.medium,
                    child: Container(
                      width: 72,
                      height: 72,
                      color: theme.colors.foreground
                          .withValues(alpha: 0.06),
                      child: const Center(
                        child: MiniText('图'),
                      ),
                    ),
                  ),
                  SizedBox(width: theme.spacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: MiniText(
                                'LACOSTE 经典款拉链外套 男士棉质夹克',
                                style: theme.typography.body.copyWith(
                                  color: theme.colors.foreground,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: theme.spacing.sm),
                            MiniTag(
                              label: '待收货',
                              tone: MiniTagTone.neutral,
                            ),
                          ],
                        ),
                        SizedBox(height: theme.spacing.xs),
                        MiniText(
                          '深蓝色 · L 码 · 1 件',
                          style: theme.typography.small.copyWith(
                            color: theme.colors.foreground
                                .withValues(alpha: 0.7),
                          ),
                        ),
                        SizedBox(height: theme.spacing.xs),
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            MiniText(
                              '预计 2 天内送达',
                              style: theme.typography.small.copyWith(
                                color: theme.colors.foreground
                                    .withValues(alpha: 0.6),
                              ),
                            ),
                            MiniText(
                              '¥ 899.00',
                              style: theme.typography.title.copyWith(
                                color: theme.colors.foreground,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: theme.spacing.sm),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  MiniButton(
                    label: '查看详情',
                    variant: MiniButtonVariant.ghost,
                    onPressed: () {
                      MiniToast.show(context, '查看订单详情');
                    },
                  ),
                  SizedBox(width: theme.spacing.sm),
                  MiniButton(
                    label: '确认收货',
                    onPressed: () {
                      MiniToast.show(context, '确认收货');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: theme.spacing.md),
        MiniCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: theme.radius.medium,
                    child: Container(
                      width: 72,
                      height: 72,
                      color: theme.colors.foreground
                          .withValues(alpha: 0.06),
                      child: const Center(
                        child: MiniText('图'),
                      ),
                    ),
                  ),
                  SizedBox(width: theme.spacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: MiniText(
                                'DIESEL Logo 印花连帽卫衣 男士',
                                style: theme.typography.body.copyWith(
                                  color: theme.colors.foreground,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: theme.spacing.sm),
                            MiniTag(
                              label: '已完成',
                              tone: MiniTagTone.success,
                            ),
                          ],
                        ),
                        SizedBox(height: theme.spacing.xs),
                        MiniText(
                          '酒红色 · M 码 · 1 件',
                          style: theme.typography.small.copyWith(
                            color: theme.colors.foreground
                                .withValues(alpha: 0.7),
                          ),
                        ),
                        SizedBox(height: theme.spacing.xs),
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            MiniText(
                              '已签收 · 2026-08-18',
                              style: theme.typography.small.copyWith(
                                color: theme.colors.foreground
                                    .withValues(alpha: 0.6),
                              ),
                            ),
                            MiniText(
                              '¥ 1,299.00',
                              style: theme.typography.title.copyWith(
                                color: theme.colors.foreground,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: theme.spacing.sm),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  MiniButton(
                    label: '再次购买',
                    variant: MiniButtonVariant.ghost,
                    onPressed: () {
                      MiniToast.show(context, '再次购买');
                    },
                  ),
                  SizedBox(width: theme.spacing.sm),
                  MiniButton(
                    label: '评价晒单',
                    onPressed: () {
                      MiniToast.show(context, '评价晒单');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: theme.spacing.lg),
      ],
    );
  }

  Widget _buildFeedTab(MiniTheme theme) {
    return ListView(
      padding: EdgeInsets.all(theme.spacing.lg),
      children: const <Widget>[
        MiniSectionHeader(
          title: '推荐内容',
          subtitle: 'Product cards / feed items go here',
        ),
      ],
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
        borderRadius: BorderRadius.circular(14),
        color: color.withValues(alpha: 0.08),
        border: Border.all(
          color: color.withValues(alpha: 0.4),
        ),
      ),
      child: Center(
        child: Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: color,
          ),
        ),
      ),
    );
  }
}
