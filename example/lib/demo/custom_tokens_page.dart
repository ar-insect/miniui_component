import 'package:flutter/widgets.dart';
import 'package:miniui_component/miniui.dart';

class MiniCustomTokensPage extends StatefulWidget {
  static const String routeName = '/custom-tokens';

  final MiniThemeController controller;

  const MiniCustomTokensPage({
    super.key,
    required this.controller,
  });

  @override
  State<MiniCustomTokensPage> createState() => _MiniCustomTokensPageState();
}

class _MiniCustomTokensPageState extends State<MiniCustomTokensPage> {
  late double _radiusValue;
  late double _fontScale;
  late double _spacingScale;

  @override
  void initState() {
    super.initState();
    final MiniTheme theme = widget.controller.theme;
    _radiusValue = theme.radius.medium.topLeft.x;
    _fontScale = (theme.typography.body.fontSize ?? 15) / 15;
    _spacingScale = theme.spacing.md / 14;
  }

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = MiniThemeProvider.of(context);

    return MiniPageScaffold(
      appBar: MiniAppBar(
        leading: const MiniBackButton(),
        title: const MiniText('Custom appearance'),
        centerTitle: true,
      ),
      body: Container(
        color: theme.colors.background,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(theme.spacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildThemePresets(theme),
              SizedBox(height: theme.spacing.lg),
              _buildSliders(theme),
              SizedBox(height: theme.spacing.lg),
              _buildPreview(theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSliders(MiniTheme theme) {
    return MiniCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const MiniText(
            'Global parameters',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: theme.spacing.sm),
          _MiniSliderRow(
            label: 'Corner radius (medium)',
            value: _radiusValue,
            min: 0,
            max: 24,
            formatValue: (double v) => v.toStringAsFixed(0),
            onChanged: (double v) {
              setState(() {
                _radiusValue = v;
              });
              final MiniRadiusTokens r = widget.controller.theme.radius;
              widget.controller.updateTokens(
                radius: r.copyWith(
                  medium: BorderRadius.all(Radius.circular(v)),
                  large: BorderRadius.all(Radius.circular(v + 6)),
                ),
              );
            },
          ),
          SizedBox(height: theme.spacing.sm),
          _MiniSliderRow(
            label: 'Font scale',
            value: _fontScale,
            min: 0.8,
            max: 1.4,
            formatValue: (double v) => v.toStringAsFixed(2),
            onChanged: (double v) {
              setState(() {
                _fontScale = v;
              });
              final MiniTypographyTokens t = widget.controller.theme.typography;
              MiniTypographyTokens scaled = t.copyWith(
                body: t.body.copyWith(fontSize: 15 * v),
                small: t.small.copyWith(fontSize: 13 * v),
                title: t.title.copyWith(fontSize: 18 * v),
                heading: t.heading.copyWith(fontSize: 26 * v),
              );
              widget.controller.updateTokens(typography: scaled);
            },
          ),
          SizedBox(height: theme.spacing.sm),
          _MiniSliderRow(
            label: 'Spacing scale',
            value: _spacingScale,
            min: 0.7,
            max: 1.5,
            formatValue: (double v) => v.toStringAsFixed(2),
            onChanged: (double v) {
              setState(() {
                _spacingScale = v;
              });
              final MiniSpacingTokens s = widget.controller.theme.spacing;
              double scale(double x) => x * v;
              final MiniSpacingTokens scaled = s.copyWith(
                sm: scale(10),
                md: scale(14),
                lg: scale(20),
                xl: scale(28),
              );
              widget.controller.updateTokens(spacing: scaled);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPreview(MiniTheme theme) {
    return MiniCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const MiniText(
            'Preview',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: theme.spacing.md),
          MiniButton(
            label: 'Primary button',
            onPressed: () {},
          ),
          SizedBox(height: theme.spacing.sm),
          MiniButton(
            label: 'Ghost button',
            variant: MiniButtonVariant.ghost,
            onPressed: () {},
          ),
          SizedBox(height: theme.spacing.md),
          const MiniText('Heading text'),
          const MiniText('Section title'),
          const MiniText('Body text for primary content.'),
          const MiniText('Small caption text for additional hints.'),
        ],
      ),
    );
  }
  
  Widget _buildThemePresets(MiniTheme theme) {
    final List<MiniTheme> presets = widget.controller.availableThemes
        .where((MiniTheme t) => t.name != 'compact' && t.name != 'rounded')
        .toList();

    return MiniCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          MiniText(
            'Preset theme: ${theme.name}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: theme.spacing.sm),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: presets
                .map(
                  (MiniTheme t) => MiniButton(
                    label: t.name,
                    variant: t.name == theme.name
                        ? MiniButtonVariant.primary
                        : MiniButtonVariant.ghost,
                    onPressed: () {
                      widget.controller.setTheme(t);
                      final MiniTheme next = widget.controller.theme;
                      setState(() {
                        _radiusValue = next.radius.medium.topLeft.x;
                        _fontScale =
                            (next.typography.body.fontSize ?? 15) / 15;
                        _spacingScale = next.spacing.md / 14;
                      });
                    },
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _MiniSliderRow extends StatelessWidget {
  final String label;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;
  final String Function(double) formatValue;

  const _MiniSliderRow({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    required this.formatValue,
  });

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = MiniThemeProvider.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            MiniText(
              label,
              style: theme.typography.small.copyWith(
                color: theme.colors.foreground.withOpacity(0.8),
              ),
            ),
            MiniText(
              formatValue(value),
              style: theme.typography.small.copyWith(
                color: theme.colors.foreground.withOpacity(0.6),
              ),
            ),
          ],
        ),
        SizedBox(height: theme.spacing.xs),
        MiniSlider(
          value: value,
          min: min,
          max: max,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
