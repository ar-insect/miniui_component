import 'package:flutter/widgets.dart';
import 'package:miniui/core/base/base_component.dart';

/// Search bar with pill-shaped background, placeholder and clear button.
class MiniSearchBar extends StatefulWidget {
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final String placeholder;

  const MiniSearchBar({
    super.key,
    this.initialValue,
    this.onChanged,
    this.placeholder = 'Search',
  });

  @override
  State<MiniSearchBar> createState() => _MiniSearchBarState();
}

class _MiniSearchBarState extends State<MiniSearchBar> {
  late final TextEditingController _controller =
      TextEditingController(text: widget.initialValue);
  late final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = MiniThemeProvider.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colors.background,
        borderRadius: theme.radius.pill,
        border: Border.all(
          color: theme.colors.foreground.withValues(alpha: 0.12),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: theme.spacing.md,
          vertical: theme.spacing.xs,
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: theme.spacing.lg,
              height: theme.spacing.lg,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: theme.colors.foreground.withValues(alpha: 0.4),
                  width: 1.5,
                ),
              ),
              child: Center(
                child: Container(
                  width: theme.spacing.xs,
                  height: theme.spacing.xs,
                  decoration: BoxDecoration(
                    color: theme.colors.foreground.withValues(alpha: 0.6),
                    borderRadius: theme.radius.small,
                  ),
                ),
              ),
            ),
            SizedBox(width: theme.spacing.sm),
            Expanded(
              child: EditableText(
                controller: _controller,
                focusNode: _focusNode,
                keyboardType: TextInputType.text,
                style: theme.typography.body.copyWith(
                  color: theme.colors.foreground,
                ),
                cursorColor: theme.colors.primary,
                backgroundCursorColor: theme.colors.background,
                selectionColor: theme.colors.primary.withValues(alpha: 0.2),
                onChanged: widget.onChanged,
              ),
            ),
            if (_controller.text.isNotEmpty)
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  _controller.clear();
                  widget.onChanged?.call('');
                  setState(() {});
                },
                child: Padding(
                  padding: EdgeInsets.only(left: theme.spacing.sm),
                  child: Container(
                    width: theme.spacing.md,
                    height: theme.spacing.md,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          theme.colors.foreground.withValues(alpha: 0.15),
                    ),
                    child: Center(
                      child: Container(
                        width: theme.spacing.xs,
                        height: 1.5,
                        decoration: BoxDecoration(
                          color: theme.colors.foreground
                              .withValues(alpha: 0.7),
                          borderRadius: theme.radius.small,
                        ),
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
}
