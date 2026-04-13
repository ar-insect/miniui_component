import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:miniui/core/base/base_component.dart';

/// Basic text input component with placeholder and keyboard type support.
class MiniInput extends StatefulWidget {
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final String? placeholder;
  final TextInputType keyboardType;

  const MiniInput({
    super.key,
    this.initialValue,
    this.onChanged,
    this.placeholder,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<MiniInput> createState() => _MiniInputState();
}

class _MiniInputState extends State<MiniInput> {
  late final TextEditingController _controller =
      TextEditingController(text: widget.initialValue);
  late final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_handleTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTextChanged);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = MiniThemeProvider.of(context);
    final bool isIOS = defaultTargetPlatform == TargetPlatform.iOS;

    BoxDecoration decoration;
    EdgeInsetsGeometry padding = theme.componentSizes.inputPadding;

    if (isIOS) {
      decoration = BoxDecoration(
        color: theme.colors.foreground.withValues(alpha: 0.06),
        borderRadius: theme.radius.pill,
        border: Border.all(
          color: theme.colors.foreground.withValues(alpha: 0.06),
        ),
      );
    } else {
      decoration = BoxDecoration(
        color: theme.colors.background,
        borderRadius: theme.radius.medium,
        border: Border.all(
          color: theme.colors.foreground.withValues(alpha: 0.2),
        ),
      );
    }

    return DecoratedBox(
      decoration: decoration,
      child: Padding(
        padding: padding,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            EditableText(
              controller: _controller,
              focusNode: _focusNode,
              keyboardType: widget.keyboardType,
              style: theme.typography.body.copyWith(
                color: theme.colors.foreground,
              ),
              cursorColor: theme.colors.primary,
              backgroundCursorColor: theme.colors.background,
              selectionColor: theme.colors.primary.withValues(alpha: 0.2),
              inputFormatters: <TextInputFormatter>[],
              onChanged: widget.onChanged,
            ),
            if (_controller.text.isEmpty && (widget.placeholder ?? '').isNotEmpty)
              IgnorePointer(
                child: Text(
                  widget.placeholder!,
                  style: theme.typography.body.copyWith(
                    color: theme.colors.foreground.withValues(alpha: 0.4),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _handleTextChanged() {
    setState(() {});
  }
}
