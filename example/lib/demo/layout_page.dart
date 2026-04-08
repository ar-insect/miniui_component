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
                        color:
                            theme.colors.foreground.withValues(alpha: 0.7),
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
          MiniTabItem(
            label: '首页',
            icon: _MiniNavIcon(type: _MiniNavIconType.home),
          ),
          MiniTabItem(
            label: '消息',
            icon: _MiniNavIcon(type: _MiniNavIconType.message),
          ),
          MiniTabItem(
            label: '我的',
            icon: _MiniNavIcon(type: _MiniNavIconType.profile),
          ),
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

enum _MiniNavIconType { home, message, profile }

class _MiniNavIcon extends StatelessWidget {
  final _MiniNavIconType type;

  const _MiniNavIcon({required this.type});

  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    final Color color = iconTheme.color ?? const Color(0xFF000000);
    final double size = iconTheme.size ?? 24;

    switch (type) {
      case _MiniNavIconType.home:
        return CustomPaint(
          size: Size.square(size),
          painter: _HomeIconPainter(color),
        );
      case _MiniNavIconType.message:
        return CustomPaint(
          size: Size.square(size),
          painter: _MessageIconPainter(color),
        );
      case _MiniNavIconType.profile:
        return CustomPaint(
          size: Size.square(size),
          painter: _ProfileIconPainter(color),
        );
    }
  }
}

class _HomeIconPainter extends CustomPainter {
  final Color color;

  _HomeIconPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.09
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final Path path = Path();
    final double w = size.width;
    final double h = size.height;
    path.moveTo(w * 0.18, h * 0.50);
    path.lineTo(w * 0.50, h * 0.20);
    path.lineTo(w * 0.82, h * 0.50);
    path.lineTo(w * 0.82, h * 0.80);
    path.lineTo(w * 0.18, h * 0.80);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _HomeIconPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

class _MessageIconPainter extends CustomPainter {
  final Color color;

  _MessageIconPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.09
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final double w = size.width;
    final double h = size.height;

    final RRect bubble = RRect.fromLTRBR(
      w * 0.15,
      h * 0.20,
      w * 0.85,
      h * 0.70,
      Radius.circular(w * 0.18),
    );

    canvas.drawRRect(bubble, paint);

    final Path tail = Path();
    tail.moveTo(w * 0.32, h * 0.70);
    tail.lineTo(w * 0.42, h * 0.85);
    tail.lineTo(w * 0.50, h * 0.70);
    canvas.drawPath(tail, paint);
  }

  @override
  bool shouldRepaint(covariant _MessageIconPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

class _ProfileIconPainter extends CustomPainter {
  final Color color;

  _ProfileIconPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.09
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final double w = size.width;
    final double h = size.height;

    final Offset headCenter = Offset(w * 0.50, h * 0.32);
    final double headRadius = w * 0.18;
    canvas.drawCircle(headCenter, headRadius, paint);

    final Rect bodyRect = Rect.fromLTRB(
      w * 0.20,
      h * 0.52,
      w * 0.80,
      h * 0.85,
    );
    final RRect body = RRect.fromRectAndRadius(
      bodyRect,
      Radius.circular(w * 0.20),
    );
    canvas.drawRRect(body, paint);
  }

  @override
  bool shouldRepaint(covariant _ProfileIconPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
