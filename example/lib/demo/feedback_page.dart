import 'package:flutter/widgets.dart';
import 'package:miniui_component/miniui.dart';

class MiniFeedbackDemoPage extends StatefulWidget {
  static const String routeName = '/feedback-demo';

  const MiniFeedbackDemoPage({super.key});

  @override
  State<MiniFeedbackDemoPage> createState() => _MiniFeedbackDemoPageState();
}

class _MiniFeedbackDemoPageState extends State<MiniFeedbackDemoPage> {
  OverlayEntry? _loadingEntry;

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = MiniThemeProvider.of(context);
    final MiniLocalizations i18n = MiniLocalizations.of(context);

    return MiniPageScaffold(
      appBar: MiniAppBar(
        leading: const MiniBackButton(),
        title: MiniText(i18n.feedbackDemoTitle),
        centerTitle: true,
      ),
      body: Container(
        color: theme.colors.background,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(theme.spacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildButtonsSection(theme),
              SizedBox(height: theme.spacing.lg),
              _buildStatusSection(theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonsSection(MiniTheme theme) {
    return MiniCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const MiniText(
            'Overlays & feedback',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: theme.spacing.md),
          MiniButton(
            label: 'Show Dialog',
            onPressed: () async {
              await MiniDialog.show(
                context,
                title: 'MiniDialog',
                message: 'This is a simple dialog example.',
              );
            },
          ),
          SizedBox(height: theme.spacing.sm),
          MiniButton(
            label: 'Show bottom sheet',
            variant: MiniButtonVariant.ghost,
            onPressed: () {
              MiniBottomSheet.show<void>(
                context,
                builder: (BuildContext context) {
                  final MiniTheme theme = MiniThemeProvider.of(context);

                  return MiniBottomSheet(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        MiniText(
                          'Bottom sheet title',
                          style: theme.typography.title.copyWith(
                            color: theme.colors.foreground,
                          ),
                        ),
                        SizedBox(height: 8),
                        MiniText(
                          'Use MiniBottomSheet to present any custom content '
                          'from the bottom of the screen.',
                          style: theme.typography.body.copyWith(
                            color: theme.colors.foreground.withValues(
                              alpha: 0.8,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        const MiniDivider(),
                        SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: MiniButton(
                            label: MiniLocalizations.of(context).confirmLabel,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          SizedBox(height: theme.spacing.sm),
          MiniBanner(
            message: 'Saved successfully',
            variant: MiniBannerVariant.success,
            actionLabel: 'Undo',
            onAction: () {
              MiniToast.show(context, 'Tapped Undo');
            },
          ),
          SizedBox(height: theme.spacing.sm),
          MiniButton(
            label: 'Show Snackbar',
            variant: MiniButtonVariant.ghost,
            onPressed: () {
              MiniSnackbar.show(
                context,
                'Saved successfully',
                actionLabel: 'Undo',
                onAction: () {
                  MiniToast.show(context, 'Tapped Undo');
                },
              );
            },
          ),
          SizedBox(height: theme.spacing.sm),
          MiniButton(
            label: 'Show full-screen Loading',
            variant: MiniButtonVariant.ghost,
            onPressed: () async {
              _loadingEntry = MiniLoadingOverlay.show(context);
              await Future<void>.delayed(const Duration(seconds: 2));
              if (_loadingEntry != null) {
                MiniLoadingOverlay.hide(_loadingEntry!);
                _loadingEntry = null;
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatusSection(MiniTheme theme) {
    return MiniCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const MiniSectionHeader(
            title: 'Status showcase',
            subtitle: 'Badges and skeleton loaders',
          ),
          SizedBox(height: theme.spacing.md),
          Row(
            children: <Widget>[
              MiniBadge(
                child: MiniAvatar(
                  text: 'A',
                  size: 40,
                ),
                value: '3',
              ),
              SizedBox(width: theme.spacing.lg),
              MiniBadge(
                child: MiniAvatar(
                  text: 'B',
                  size: 40,
                ),
                dot: true,
              ),
            ],
          ),
          SizedBox(height: theme.spacing.md),
          Row(
            children: const <Widget>[
              MiniSkeleton.circle(size: 40),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MiniSkeleton.rect(width: double.infinity, height: 12),
                    SizedBox(height: 8),
                    MiniSkeleton.rect(width: 160, height: 12),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
