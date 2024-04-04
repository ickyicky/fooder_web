import 'package:flutter/material.dart';
import 'package:blur/blur.dart';

class BlurContainer extends StatelessWidget {
  final Widget? child;
  final double? height;
  final double? width;

  const BlurContainer({super.key, this.height, this.width, this.child});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;

    var blured = Blur(
      blur: 10,
      blurColor: colorScheme.surface.withOpacity(0.1),
      child: Container(
        height: height,
        width: width,
        color: colorScheme.surface.withOpacity(0.1),
      ),
    );

    if (child == null) {
      return blured;
    }

    return Stack(
      children: [
        blured,
        child!,
      ],
    );
  }
}
