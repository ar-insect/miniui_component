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
            '‹ 返回',
            style: theme.typography.body.copyWith(
              color: theme.colors.foreground,
            ),
          ),
        ),
        title: const MiniText('反馈组件示例'),
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
            '弹层与反馈',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: theme.spacing.md),
          MiniButton(
            label: '显示 Dialog',
            onPressed: () async {
              await MiniDialog.show(
                context,
                title: 'MiniDialog',
                message: '这是一个简易的对话框示例。',
                confirmLabel: '确认',
                cancelLabel: '取消',
              );
            },
          ),
          SizedBox(height: theme.spacing.sm),
          MiniButton(
            label: '显示 ActionSheet',
            variant: MiniButtonVariant.ghost,
            onPressed: () {
              MiniActionSheet.show(
                context,
                title: '操作',
                actions: <MiniActionSheetAction>[
                  MiniActionSheetAction(
                    label: '复制',
                    onPressed: () {
                      MiniToast.show(context, '点击了复制');
                    },
                  ),
                  MiniActionSheetAction(
                    label: '删除',
                    destructive: true,
                    onPressed: () {
                      MiniToast.show(context, '点击了删除');
                    },
                  ),
                ],
              );
            },
          ),
          SizedBox(height: theme.spacing.sm),
          MiniButton(
            label: '显示 Snackbar',
            variant: MiniButtonVariant.ghost,
            onPressed: () {
              MiniSnackbar.show(
                context,
                '保存成功',
                actionLabel: '撤销',
                onAction: () {
                  MiniToast.show(context, '点击了撤销');
                },
              );
            },
          ),
          SizedBox(height: theme.spacing.sm),
          MiniButton(
            label: '显示全屏 Loading',
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
            '状态展示',
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

