import 'package:flutter/widgets.dart';
import 'package:miniui/miniui.dart';

class MiniLayoutDemoPage extends StatefulWidget {
  static const String routeName = '/layout-demo';

  const MiniLayoutDemoPage({super.key});

  @override
  State<MiniLayoutDemoPage> createState() => _MiniLayoutDemoPageState();
}

class _MiniLayoutDemoPageState extends State<MiniLayoutDemoPage> {
  int _currentTab = 0;
  String _segment = 'all';

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
        title: const MiniText('布局与导航示例'),
        centerTitle: true,
      ),
      body: Container(
        color: theme.colors.background,
        child: Padding(
          padding: EdgeInsets.all(theme.spacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const MiniText(
                '顶部 SegmentedControl',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: theme.spacing.sm),
              MiniSegmentedControl<String>(
                segments: const <MiniSegment<String>>[
                  MiniSegment<String>(value: 'all', label: '全部'),
                  MiniSegment<String>(value: 'fav', label: '收藏'),
                  MiniSegment<String>(value: 'archived', label: '归档'),
                ],
                value: _segment,
                onChanged: (String v) {
                  setState(() {
                    _segment = v;
                  });
                },
              ),
              SizedBox(height: theme.spacing.lg),
              const MiniText(
                '内容区域',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: theme.spacing.sm),
              MiniCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    MiniText(
                      '当前 Tab：$_currentTab',
                      style: theme.typography.body
                          .copyWith(color: theme.colors.foreground),
                    ),
                    SizedBox(height: theme.spacing.xs),
                    MiniText(
                      '当前 Segment：$_segment',
                      style: theme.typography.small.copyWith(
                        color: theme.colors.foreground.withOpacity(0.7),
                      ),
                    ),
                    SizedBox(height: theme.spacing.md),
                    const MiniText(
                      '这里可以替换成真实的列表、表单或详情页内容，MiniPageScaffold 负责处理顶部导航、底部导航和安全区域。',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomBar: MiniTabBar(
        items: const <MiniTabItem>[
          MiniTabItem(label: '首页'),
          MiniTabItem(label: '消息'),
          MiniTabItem(label: '我的'),
        ],
        currentIndex: _currentTab,
        onTap: (int index) {
          setState(() {
            _currentTab = index;
          });
        },
      ),
    );
  }
}

