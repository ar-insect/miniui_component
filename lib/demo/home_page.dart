import 'package:flutter/widgets.dart';
import 'package:miniui/demo/list_page.dart';
import 'package:miniui/demo/layout_page.dart';
import 'package:miniui/demo/tokens_page.dart';
import 'package:miniui/demo/feedback_page.dart';
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
                _buildThemeCard(theme),
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
    return MiniText(
      'MiniUi',
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildThemeCard(MiniTheme theme) {
    return MiniCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          MiniText(
            '当前主题：${theme.name}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.controller.availableThemes
                .map(
                  (MiniTheme t) => MiniButton(
                    label: t.name,
                    variant: t == theme
                        ? MiniButtonVariant.primary
                        : MiniButtonVariant.ghost,
                    onPressed: () {
                      widget.controller.setTheme(t);
                    },
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildComponentsCard(MiniTheme theme) {
    return MiniCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const MiniText(
            '组件示例',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          MiniInput(
            placeholder: '输入一些文字',
            onChanged: (_) {},
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              MiniButton(
                label: '主按钮',
                onPressed: () {},
              ),
              const SizedBox(width: 12),
              MiniButton(
                label: '幽灵按钮',
                variant: MiniButtonVariant.ghost,
                onPressed: () {},
              ),
              const SizedBox(width: 12),
              MiniButton(
                label: '危险',
                variant: MiniButtonVariant.danger,
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: const <Widget>[
              MiniTag(label: '标签'),
              SizedBox(width: 8),
              MiniTag(label: '状态'),
            ],
          ),
          const SizedBox(height: 12),
          const Align(
            alignment: Alignment.centerLeft,
            child: MiniLoading(),
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
            '表单示例',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          MiniCheckbox(
            value: _agreed,
            label: '我已阅读并同意协议',
            onChanged: (bool v) {
              setState(() {
                _agreed = v;
              });
            },
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              MiniRadio<String>(
                value: 'a',
                groupValue: _selectedOption,
                label: '选项 A',
                onChanged: (String v) {
                  setState(() {
                    _selectedOption = v;
                  });
                },
              ),
              SizedBox(width: theme.spacing.lg),
              MiniRadio<String>(
                value: 'b',
                groupValue: _selectedOption,
                label: '选项 B',
                onChanged: (String v) {
                  setState(() {
                    _selectedOption = v;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const MiniText('接收推送通知'),
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
            '列表与 Toast 示例',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          const MiniDivider(),
          MiniListItem(
            title: '账号安全',
            subtitle: '密码、登录设备管理',
            trailing: const MiniTag(label: '推荐'),
            onTap: () {
              MiniToast.show(context, '点击了账号安全');
            },
          ),
          const MiniDivider(),
          MiniListItem(
            title: '消息通知',
            subtitle: '应用内消息与推送',
            trailing: MiniSwitch(
              value: _notificationsEnabled,
              onChanged: (bool v) {
                setState(() {
                  _notificationsEnabled = v;
                });
              },
            ),
            onTap: () {
              MiniToast.show(context, '点击了消息通知');
            },
          ),
          const MiniDivider(),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: MiniButton(
              label: '显示 Toast',
              variant: MiniButtonVariant.ghost,
              onPressed: () {
                MiniToast.show(context, '这是一条 MiniToast 提示');
              },
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: MiniButton(
              label: '查看列表页示例',
              variant: MiniButtonVariant.ghost,
              onPressed: () {
                Navigator.of(context).pushNamed(MiniListDemoPage.routeName);
              },
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: MiniButton(
              label: '查看主题 Tokens 示例',
              variant: MiniButtonVariant.ghost,
              onPressed: () {
                Navigator.of(context).pushNamed(MiniTokensPage.routeName);
              },
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: MiniButton(
              label: '查看布局与导航示例',
              variant: MiniButtonVariant.ghost,
              onPressed: () {
                Navigator.of(context).pushNamed(MiniLayoutDemoPage.routeName);
              },
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: MiniButton(
              label: '查看反馈组件示例',
              variant: MiniButtonVariant.ghost,
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(MiniFeedbackDemoPage.routeName);
              },
            ),
          ),
        ],
      ),
    );
  }
}
