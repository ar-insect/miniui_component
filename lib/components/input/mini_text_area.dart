import 'package:flutter/widgets.dart';
import 'package:miniui_component/core/base/base_component.dart';

class MiniTextArea extends StatefulWidget {
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final String? placeholder;
  final int minLines;
  final int maxLines;

  const MiniTextArea({
    super.key,
    this.initialValue,
    this.onChanged,
    this.placeholder,
    this.minLines = 3,
    this.maxLines = 5,
  });

  @override
  State<MiniTextArea> createState() => _MiniTextAreaState();
}

class _MiniTextAreaState extends State<MiniTextArea> {
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

    final BoxDecoration decoration = BoxDecoration(
      color: theme.colors.background,
      borderRadius: theme.radius.medium,
      border: Border.all(
        color: theme.colors.foreground.withValues(alpha: 0.2),
      ),
    );

    final EdgeInsetsGeometry padding = EdgeInsets.symmetric(
      horizontal: theme.spacing.md,
      vertical: theme.spacing.sm,
    );

    return DecoratedBox(
      decoration: decoration,
      child: Padding(
        padding: padding,
        child: Stack(
          alignment: Alignment.topLeft,
          children: <Widget>[
            EditableText(
              controller: _controller,
              focusNode: _focusNode,
              keyboardType: TextInputType.multiline,
              maxLines: widget.maxLines,
              minLines: widget.minLines,
              style: theme.typography.body.copyWith(
                color: theme.colors.foreground,
              ),
              cursorColor: theme.colors.primary,
              backgroundCursorColor: theme.colors.background,
              selectionColor:
                  theme.colors.primary.withValues(alpha: 0.2),
              onChanged: widget.onChanged,
            ),
            if (_controller.text.isEmpty &&
                (widget.placeholder ?? '').isNotEmpty)
              IgnorePointer(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: theme.spacing.xs,
                  ),
                  child: Text(
                    widget.placeholder!,
                    style: theme.typography.body.copyWith(
                      color: theme.colors.foreground.withValues(
                        alpha: 0.4,
                      ),
                    ),
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

