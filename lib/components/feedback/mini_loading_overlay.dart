import 'package:flutter/widgets.dart';
import 'package:miniui/miniui.dart';

/// 全屏 Loading 浮层，通过 Overlay 覆盖当前界面。
class MiniLoadingOverlay extends BaseComponent {
  const MiniLoadingOverlay({super.key});

  /// 显示全屏 Loading 并返回对应的 [OverlayEntry]，用于后续关闭。
  static OverlayEntry show(BuildContext context) {
    final OverlayState? overlay = Overlay.of(context);
    if (overlay == null) {
      throw StateError('No Overlay found in context');
    }

    final MiniTheme theme = MiniThemeProvider.of(context);

    late final OverlayEntry entry;
    entry = OverlayEntry(
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

  /// 隐藏指定的 Loading 浮层。
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
