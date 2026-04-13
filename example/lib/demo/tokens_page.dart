import 'package:flutter/widgets.dart';
import 'package:miniui/miniui.dart';

class MiniTokensPage extends StatelessWidget {
  static const String routeName = '/tokens';

  const MiniTokensPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = MiniThemeProvider.of(context);

    return MiniPageScaffold(
      appBar: MiniAppBar(
        leading: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.of(context).pop();
          },
          child: MiniText(
            '‹ Back',
            style: theme.typography.body.copyWith(
              color: theme.colors.foreground,
            ),
          ),
        ),
        title: const MiniText('Theme Tokens'),
        centerTitle: true,
      ),
      body: Container(
        color: theme.colors.background,
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildColorSection(theme),
                const SizedBox(height: 16),
                _buildSpacingSection(theme),
                const SizedBox(height: 16),
                _buildRadiusSection(theme),
                const SizedBox(height: 16),
                _buildTypographySection(theme),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildColorSection(MiniTheme theme) {
    final MiniColorTokens c = theme.colors;

    return MiniCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const MiniText(
            'Colors',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              _buildColorSwatch('Primary', c.primary, theme),
              _buildColorSwatch('Accent', c.accent, theme),
              _buildColorSwatch('Danger', c.danger, theme),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              _buildColorSwatch('Background', c.background, theme),
              _buildColorSwatch('Foreground', c.foreground, theme),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildColorSwatch(String label, Color color, MiniTheme theme) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: theme.radius.small,
              border: Border.all(
                color: theme.colors.foreground.withValues(alpha: 0.08),
              ),
            ),
          ),
          const SizedBox(height: 4),
          MiniText(
            label,
            style: theme.typography.small.copyWith(
              color: theme.colors.foreground.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpacingSection(MiniTheme theme) {
    final MiniSpacingTokens s = theme.spacing;

    return MiniCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const MiniText(
            'Spacing',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              _buildSpacingBar('xs', s.xs, theme),
              _buildSpacingBar('sm', s.sm, theme),
              _buildSpacingBar('md', s.md, theme),
              _buildSpacingBar('lg', s.lg, theme),
              _buildSpacingBar('xl', s.xl, theme),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSpacingBar(String label, double value, MiniTheme theme) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: value,
            decoration: BoxDecoration(
              color: theme.colors.primary.withValues(alpha: 0.2),
              borderRadius: theme.radius.small,
            ),
          ),
          const SizedBox(height: 4),
          MiniText(
            '$label (${value.toStringAsFixed(0)})',
            style: theme.typography.small.copyWith(
              color: theme.colors.foreground.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRadiusSection(MiniTheme theme) {
    final MiniRadiusTokens r = theme.radius;

    return MiniCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const MiniText(
            'Radius',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              _buildRadiusBox('Small', r.small, theme),
              _buildRadiusBox('Medium', r.medium, theme),
              _buildRadiusBox('Large', r.large, theme),
              _buildRadiusBox('Pill', r.pill, theme),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRadiusBox(
      String label, BorderRadius radius, MiniTheme theme) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: theme.colors.primary.withValues(alpha: 0.12),
              borderRadius: radius,
            ),
          ),
          const SizedBox(height: 4),
          MiniText(
            label,
            style: theme.typography.small.copyWith(
              color: theme.colors.foreground.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypographySection(MiniTheme theme) {
    final MiniTypographyTokens t = theme.typography;

    return MiniCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const MiniText(
            'Typography',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          MiniText(
            'Heading - large title text',
            style: t.heading.copyWith(color: theme.colors.foreground),
          ),
          const SizedBox(height: 8),
          MiniText(
            'Title - section header',
            style: t.title.copyWith(color: theme.colors.foreground),
          ),
          const SizedBox(height: 8),
          MiniText(
            'Body - primary content text for most copy.',
            style: t.body.copyWith(color: theme.colors.foreground),
          ),
          const SizedBox(height: 8),
          MiniText(
            'Small - secondary helper text.',
            style: t.small.copyWith(
              color: theme.colors.foreground.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}
