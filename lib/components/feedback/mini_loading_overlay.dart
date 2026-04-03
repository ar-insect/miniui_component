import 'package:flutter/widgets.dart';
import 'package:miniui/miniui.dart';

class MiniLoadingOverlay extends BaseComponent {
  const MiniLoadingOverlay({super.key});

  static OverlayEntry show(BuildContext context) {
    final OverlayState? overlay = Overlay.of(context);
    if (overlay == null) {
      throw StateError('No Overlay found in context');
    }

    final MiniTheme theme = MiniThemeProvider.of(context);

    final OverlayEntry entry = OverlayEntry(
      builder: (BuildContext overlayContext) {
        return ColoredBox(
          color: const Color(0x66000000),
          child: Center(
            child: MiniCard(
              child: Padding(
                padding: EdgeInsets.all(theme.spacing.lg),
                child: const MiniLoading(),
              ),
            ),
          ),
        );
      },
    );

    overlay.insert(entry);
    return entry;
  }

  static void hide(OverlayEntry entry) {
    if (entry.mounted) {
      entry.remove();
    }
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

