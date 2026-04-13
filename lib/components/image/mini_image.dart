import 'package:flutter/widgets.dart';
import 'package:miniui/core/base/base_component.dart';

/// Image widget with configurable corner radius and sizing.
class MiniImage extends BaseComponent {
  final ImageProvider image;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadiusGeometry borderRadius;

  const MiniImage({
    super.key,
    required this.image,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Image(
        image: image,
        width: width,
        height: height,
        fit: fit,
      ),
    );
  }
}
