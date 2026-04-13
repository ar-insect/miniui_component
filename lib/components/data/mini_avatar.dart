import 'package:flutter/widgets.dart';
import 'package:miniui/core/base/base_component.dart';

/// Avatar component that shows an image, or generates a circular avatar from
/// the first letter of [text].
class MiniAvatar extends BaseComponent {
  final ImageProvider? image;
  final String? text;
  final double size;

  const MiniAvatar({
    super.key,
    this.image,
    this.text,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = themeOf(context);

    Widget content;

    if (image != null) {
      content = ClipRRect(
        borderRadius: BorderRadius.circular(size / 2),
        child: Image(
          image: image!,
          width: size,
          height: size,
          fit: BoxFit.cover,
        ),
      );
    } else {
      final String label =
          (text ?? '').trim().isNotEmpty ? text!.trim()[0].toUpperCase() : '?';

      content = Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: theme.colors.primary.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(size / 2),
        ),
        child: Center(
          child: Text(
            label,
            style: theme.typography.title.copyWith(
              color: theme.colors.primary,
            ),
          ),
        ),
      );
    }

    return content;
  }
}
