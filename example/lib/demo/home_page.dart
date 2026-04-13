import 'package:flutter/widgets.dart';
import 'list_page.dart';
import 'layout_page.dart';
import 'tokens_page.dart';
import 'feedback_page.dart';
import 'custom_tokens_page.dart';
import 'package:miniui/miniui.dart';

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
                _buildHeader(theme),
                const SizedBox(height: 16),
                _buildComponentsCard(theme),
                const SizedBox(height: 16),
                _buildFormCard(theme),
                const SizedBox(height: 16),
                _buildListAndToastCard(theme),
                const SizedBox(height: 16),
                const MiniEmpty(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(MiniTheme theme) {
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

  Widget _buildComponentsCard(MiniTheme theme) {
    return MiniCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const MiniText(
            'Component examples',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          MiniInput(
            placeholder: 'Type something',
            onChanged: (_) {},
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              MiniButton(
                label: 'Primary',
                onPressed: () {},
              ),
              const SizedBox(width: 12),
              MiniButton(
                label: 'Ghost',
                variant: MiniButtonVariant.ghost,
                onPressed: () {},
              ),
              const SizedBox(width: 12),
              MiniButton(
                label: 'Danger',
                variant: MiniButtonVariant.danger,
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: const <Widget>[
              MiniTag(label: 'Tag'),
              SizedBox(width: 8),
              MiniTag(label: 'Status'),
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

  Widget _buildFormCard(MiniTheme theme) {
    return MiniCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const MiniText(
            'Form examples',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          MiniCheckbox(
            value: _agreed,
            label: 'I have read and agree to the terms',
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
              const MiniText('Receive push notifications'),
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

  Widget _buildListAndToastCard(MiniTheme theme) {
    return MiniCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const MiniText(
            'List & Toast examples',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          const MiniDivider(),
          MiniListItem(
            title: 'Account security',
            subtitle: 'Password & device management',
            trailing: const MiniTag(label: 'Recommended'),
            onTap: () {
              MiniToast.show(context, 'Tapped Account security');
            },
          ),
          const MiniDivider(),
          MiniListItem(
            title: 'Notifications',
            subtitle: 'In-app messages & push',
            trailing: MiniSwitch(
              value: _notificationsEnabled,
              onChanged: (bool v) {
                setState(() {
                  _notificationsEnabled = v;
                });
              },
            ),
            onTap: () {
              MiniToast.show(context, 'Tapped Notifications');
            },
          ),
          const MiniDivider(),
          MiniListItem(
            title: 'Show Toast',
            subtitle: 'Show a lightweight message at the bottom',
            showArrow: true,
            onTap: () {
              MiniToast.show(context, 'This is a MiniToast message');
            },
          ),
          const MiniDivider(),
          MiniListItem(
            title: 'Open list demo',
            subtitle: 'Navigate to full list demo',
            showArrow: true,
            onTap: () {
              Navigator.of(context).pushNamed(MiniListDemoPage.routeName);
            },
          ),
          const MiniDivider(),
          MiniListItem(
            title: 'Open tokens demo',
            subtitle: 'View color / spacing / radius / typography tokens',
            showArrow: true,
            onTap: () {
              Navigator.of(context).pushNamed(MiniTokensPage.routeName);
            },
          ),
          const MiniDivider(),
          MiniListItem(
            title: 'Open layout & navigation demo',
            subtitle: 'Show AppBar / TabBar / PageScaffold',
            showArrow: true,
            onTap: () {
              Navigator.of(context).pushNamed(MiniLayoutDemoPage.routeName);
            },
          ),
          const MiniDivider(),
          MiniListItem(
            title: 'Open feedback demo',
            subtitle: 'Dialog / ActionSheet / Snackbar / Loading',
            showArrow: true,
            onTap: () {
              Navigator.of(context)
                  .pushNamed(MiniFeedbackDemoPage.routeName);
            },
          ),
          const MiniDivider(),
          MiniListItem(
            title: 'Open custom appearance demo',
            subtitle: 'Adjust radius / typography / spacing dynamically',
            showArrow: true,
            onTap: () {
              Navigator.of(context).pushNamed(MiniCustomTokensPage.routeName);
            },
          ),
        ],
      ),
    );
  }
}
