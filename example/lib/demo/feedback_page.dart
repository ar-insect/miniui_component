import 'package:flutter/widgets.dart';
import 'package:miniui/miniui.dart';

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
        title: const MiniText('Feedback components'),
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
                confirmLabel: 'Confirm',
                cancelLabel: 'Cancel',
              );
            },
          ),
          SizedBox(height: theme.spacing.sm),
          MiniButton(
            label: 'Show ActionSheet',
            variant: MiniButtonVariant.ghost,
            onPressed: () {
              MiniActionSheet.show(
                context,
                title: 'Actions',
                actions: <MiniActionSheetAction>[
                  MiniActionSheetAction(
                    label: 'Copy',
                    onPressed: () {
                      MiniToast.show(context, 'Tapped Copy');
                    },
                  ),
                  MiniActionSheetAction(
                    label: 'Delete',
                    destructive: true,
                    onPressed: () {
                      MiniToast.show(context, 'Tapped Delete');
                    },
                  ),
                ],
              );
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
          const MiniText(
            'Status showcase',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
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
