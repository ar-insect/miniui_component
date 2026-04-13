import 'package:flutter/widgets.dart';
import 'package:miniui/core/base/base_component.dart';

/// Text wrapper that automatically applies theme typography and foreground
/// color.
class MiniText extends BaseComponent {
  final String data;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const MiniText(
    this.data, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = themeOf(context);
    final TextStyle baseStyle =
        theme.typography.body.copyWith(color: theme.colors.foreground);

    return Text(
      data,
      style: baseStyle.merge(style),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
