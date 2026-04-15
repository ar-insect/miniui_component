import 'package:flutter/widgets.dart';
import 'package:miniui_component/miniui.dart';

class MiniResultDemoPage extends StatelessWidget {
  static const String routeName = '/result-demo';

  const MiniResultDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = MiniThemeProvider.of(context);

    return MiniPageScaffold(
      appBar: MiniAppBar(
        leading: const MiniBackButton(),
        title: const MiniText('Result demo'),
        centerTitle: true,
      ),
      body: Container(
        color: theme.colors.background,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(theme.spacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const MiniSectionHeader(
                title: 'Success',
                subtitle: 'Typical operation completed state',
              ),
              MiniResult(
                status: MiniResultStatus.success,
                title: 'Payment successful',
                description: 'Your order will be processed shortly.',
                primaryActionLabel: 'View order',
                onPrimaryAction: () {
                  MiniToast.show(context, 'View order tapped');
                },
                secondaryActionLabel: 'Back to home',
                onSecondaryAction: () {
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(height: theme.spacing.lg * 1.5),
              const MiniSectionHeader(
                title: 'Error',
                subtitle: 'When something goes wrong',
              ),
              MiniResult(
                status: MiniResultStatus.error,
                title: 'Payment failed',
                description: 'There was a problem with your card. Try again.',
                primaryActionLabel: 'Retry',
                onPrimaryAction: () {
                  MiniToast.show(context, 'Retry tapped');
                },
                secondaryActionLabel: 'Change method',
                onSecondaryAction: () {
                  MiniToast.show(context, 'Change payment method');
                },
              ),
              SizedBox(height: theme.spacing.lg * 1.5),
              const MiniSectionHeader(
                title: 'Empty',
                subtitle: 'No content state with optional action',
              ),
              MiniResult(
                status: MiniResultStatus.empty,
                title: 'No orders yet',
                description: 'Browse products and place your first order.',
                primaryActionLabel: 'Go shopping',
                onPrimaryAction: () {
                  MiniToast.show(context, 'Go shopping tapped');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
