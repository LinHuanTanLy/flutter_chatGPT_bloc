import 'package:flutter/material.dart';

class AssetsImageWidget extends StatelessWidget {
  final String assets;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Color? color;
  final AlignmentGeometry? alignment;
  final double? borderRadius;
  final BlendMode? colorBlendMode;

  const AssetsImageWidget(
      {Key? key,
      required this.assets,
      this.width,
      this.height,
      this.fit,
      this.color,
      this.borderRadius,
      this.alignment, this.colorBlendMode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget image = Image.asset(
      'assets/images/$assets',
      width: width,
      fit: fit,
      alignment: alignment ?? Alignment.center,
      color: color,
      height: height,
      colorBlendMode:colorBlendMode ,
    );

    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius!),
        child: image,
      );
    }
    return image;
  }
}
