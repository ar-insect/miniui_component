import 'package:flutter/widgets.dart';
import 'package:miniui/miniui.dart';

class MiniListDemoPage extends StatelessWidget {
  static const String routeName = '/list-demo';

  const MiniListDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = MiniThemeProvider.of(context);

    return Container(
      color: theme.colors.background,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(theme.spacing.lg),
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: theme.spacing.sm),
                      child: MiniText(
                        '‹ Back',
                        style: theme.typography.body.copyWith(
                          color: theme.colors.foreground,
                        ),
                      ),
                    ),
                  ),
                  MiniText(
                    'List demo',
                    style: theme.typography.title.copyWith(
                      color: theme.colors.foreground,
                    ),
                  ),
                ],
              ),
            ),
            const MiniDivider(),
            Expanded(
              child: ListView.separated(
                itemCount: 10,
                separatorBuilder: (BuildContext context, int index) {
                  return const MiniDivider();
                },
                itemBuilder: (BuildContext context, int index) {
                  return MiniListItem(
                    title: 'Item ${index + 1}',
                    subtitle:
                        'Description text to demonstrate MiniListItem layout.',
                    trailing: const MiniTag(label: 'View'),
                    onTap: () {
                      MiniToast.show(
                        context,
                        'Tapped item ${index + 1}',
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
