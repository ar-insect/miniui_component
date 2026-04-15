import 'package:flutter/widgets.dart';
import 'list_page.dart';
import 'tokens_page.dart';
import 'feedback_page.dart';
import 'custom_tokens_page.dart';
import 'tab_view_page.dart';
import 'form_page.dart';
import 'sliver_page.dart';
import 'profile_page.dart';
import 'grid_page.dart';
import 'result_page.dart';
import 'bottom_nav_page.dart';
import 'package:miniui_component/miniui.dart';

class MiniHomePage extends StatefulWidget {
  final MiniThemeController controller;

  const MiniHomePage({
    super.key,
    required this.controller,
  });

  @override
  State<MiniHomePage> createState() => _MiniHomePageState();
}

class _MiniHomePageState extends State<MiniHomePage> {
  bool _agreed = false;
  String _selectedOption = 'a';
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = MiniThemeProvider.of(context);
    final MiniLocalizations i18n = MiniLocalizations.of(context);

    return Container(
      color: theme.colors.background,
      alignment: Alignment.topCenter,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildHeader(theme, i18n),
                const SizedBox(height: 16),
                _buildComponentsCard(theme, i18n),
                const SizedBox(height: 16),
                _buildFormCard(theme, i18n),
                const SizedBox(height: 16),
                _buildListAndToastCard(theme, i18n),
                const SizedBox(height: 16),
                const MiniEmpty(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(MiniTheme theme, MiniLocalizations i18n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const MiniText(
          'MiniUi',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        MiniText(
          'Current theme: ${theme.name}',
          style: theme.typography.small.copyWith(
            color: theme.colors.foreground.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildComponentsCard(
    MiniTheme theme,
    MiniLocalizations i18n,
  ) {
    return MiniCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          MiniSectionHeader(
            title: i18n.homeComponentExamplesTitle,
          ),
          MiniInput(
            placeholder: i18n.homeInputPlaceholder,
            onChanged: (_) {},
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              MiniButton(
                label: i18n.primaryLabel,
                onPressed: () {},
              ),
              const SizedBox(width: 12),
              MiniButton(
                label: i18n.ghostLabel,
                variant: MiniButtonVariant.ghost,
                onPressed: () {},
              ),
              const SizedBox(width: 12),
              MiniButton(
                label: i18n.dangerLabel,
                variant: MiniButtonVariant.danger,
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              MiniTag(label: i18n.tagLabel),
              const SizedBox(width: 8),
              MiniTag(label: i18n.statusLabel),
            ],
          ),
          SizedBox(height: theme.spacing.sm),
          MiniCarousel(
            height: 140,
            items: <Widget>[
              MiniImage(
                image: const NetworkImage(
                  'https://images.pexels.com/photos/414612/pexels-photo-414612.jpeg',
                ),
                fit: BoxFit.cover,
                borderRadius: theme.radius.medium,
              ),
              MiniImage(
                image: const NetworkImage(
                  'https://images.pexels.com/photos/210186/pexels-photo-210186.jpeg',
                ),
                fit: BoxFit.cover,
                borderRadius: theme.radius.medium,
              ),
              MiniImage(
                image: const NetworkImage(
                  'https://images.pexels.com/photos/462353/pexels-photo-462353.jpeg',
                ),
                fit: BoxFit.cover,
                borderRadius: theme.radius.medium,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFormCard(
    MiniTheme theme,
    MiniLocalizations i18n,
  ) {
    return MiniCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          MiniText(
            i18n.homeFormExamplesTitle,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          MiniCheckbox(
            value: _agreed,
            label: i18n.homeAgreeTerms,
            onChanged: (bool v) {
              setState(() {
                _agreed = v;
              });
            },
          ),
          const SizedBox(height: 12),
          MiniSegmentedControl<String>(
            value: _selectedOption,
            segments: const <MiniSegment<String>>[
              MiniSegment<String>(value: 'a', label: 'Option A'),
              MiniSegment<String>(value: 'b', label: 'Option B'),
            ],
            onChanged: (String v) {
              setState(() {
                _selectedOption = v;
              });
            },
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              MiniText(i18n.homeReceivePush),
              MiniSwitch(
                value: _notificationsEnabled,
                onChanged: (bool v) {
                  setState(() {
                    _notificationsEnabled = v;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildListAndToastCard(
    MiniTheme theme,
    MiniLocalizations i18n,
  ) {
    return MiniCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          MiniSectionHeader(
            title: i18n.homeListToastExamplesTitle,
          ),
          const MiniDivider(),
          MiniListItem(
            title: i18n.homeAccountSecurityTitle,
            subtitle: i18n.homeAccountSecuritySubtitle,
            trailing: MiniTag(label: i18n.homeRecommendedTag),
            onTap: () {
              MiniToast.show(context, i18n.homeToastAccountSecurity);
            },
          ),
          const MiniDivider(),
          MiniListItem(
            title: i18n.homeNotificationsTitle,
            subtitle: i18n.homeNotificationsSubtitle,
            trailing: MiniSwitch(
              value: _notificationsEnabled,
              onChanged: (bool v) {
                setState(() {
                  _notificationsEnabled = v;
                });
              },
            ),
            onTap: () {
              MiniToast.show(context, i18n.homeToastNotifications);
            },
          ),
          const MiniDivider(),
          MiniListItem(
            title: i18n.homeShowToastTitle,
            subtitle: i18n.homeShowToastSubtitle,
            showArrow: true,
            onTap: () {
              MiniToast.show(context, i18n.homeToastGeneric);
            },
          ),
          const MiniDivider(),
          MiniListItem(
            title: i18n.homeOpenListDemo,
            subtitle: 'Navigate to full list demo',
            showArrow: true,
            onTap: () {
              Navigator.of(context).pushNamed(MiniListDemoPage.routeName);
            },
          ),
          const MiniDivider(),
          MiniListItem(
            title: i18n.homeOpenTokensDemo,
            subtitle: 'View color / spacing / radius / typography tokens',
            showArrow: true,
            onTap: () {
              Navigator.of(context).pushNamed(MiniTokensPage.routeName);
            },
          ),
          const MiniDivider(),
          MiniListItem(
            title: i18n.homeOpenFeedbackDemo,
            subtitle: 'Dialog / Snackbar / Loading overlay',
            showArrow: true,
            onTap: () {
              Navigator.of(context)
                  .pushNamed(MiniFeedbackDemoPage.routeName);
            },
          ),
          const MiniDivider(),
          MiniListItem(
            title: i18n.homeOpenCustomTokensDemo,
            subtitle: 'Adjust radius / typography / spacing dynamically',
            showArrow: true,
            onTap: () {
              Navigator.of(context).pushNamed(MiniCustomTokensPage.routeName);
            },
          ),
          const MiniDivider(),
          MiniListItem(
            title: i18n.homeOpenTabViewDemo,
            subtitle: 'MiniTabBar + PageView linkage',
            showArrow: true,
            onTap: () {
              Navigator.of(context)
                  .pushNamed(MiniTabViewDemoPage.routeName);
            },
          ),
          const MiniDivider(),
          MiniListItem(
            title: i18n.homeOpenFormDemo,
            subtitle: 'Form + validation + MiniButton',
            showArrow: true,
            onTap: () {
              Navigator.of(context).pushNamed(MiniFormDemoPage.routeName);
            },
          ),
          const MiniDivider(),
          MiniListItem(
            title: i18n.homeOpenSliverDemo,
            subtitle: 'CustomScrollView + SliverList',
            showArrow: true,
            onTap: () {
              Navigator.of(context).pushNamed(MiniSliverDemoPage.routeName);
            },
          ),
          const MiniDivider(),
          MiniListItem(
            title: i18n.homeOpenGridDemo,
            subtitle: 'MiniGrid with different column counts',
            showArrow: true,
            onTap: () {
              Navigator.of(context).pushNamed(MiniGridDemoPage.routeName);
            },
          ),
          const MiniDivider(),
          MiniListItem(
            title: i18n.homeOpenProfileDemo,
            subtitle: 'Membership / profile template',
            showArrow: true,
            onTap: () {
              Navigator.of(context)
                  .pushNamed(MiniProfileDemoPage.routeName);
            },
          ),
          const MiniDivider(),
          MiniListItem(
            title: i18n.homeOpenResultDemo,
            subtitle: 'MiniResult success / error / empty',
            showArrow: true,
            onTap: () {
              Navigator.of(context)
                  .pushNamed(MiniResultDemoPage.routeName);
            },
          ),
          const MiniDivider(),
          MiniListItem(
            title: i18n.homeOpenBottomNavDemo,
            subtitle: 'MiniBottomNavScaffold template',
            showArrow: true,
            onTap: () {
              Navigator.of(context)
                  .pushNamed(MiniBottomNavDemoPage.routeName);
            },
          ),
        ],
      ),
    );
  }
}
