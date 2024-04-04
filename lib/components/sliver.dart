import 'package:flutter/material.dart';
import 'package:fooder/components/blur_container.dart';

class ClipShadowPath extends StatelessWidget {
  final Shadow shadow;
  final CustomClipper<Path> clipper;
  final Widget child;

  const ClipShadowPath({
    super.key,
    required this.shadow,
    required this.clipper,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ClipShadowShadowPainter(
        clipper: clipper,
        shadow: shadow,
      ),
      child: ClipPath(clipper: clipper, child: child),
    );
  }
}

class _ClipShadowShadowPainter extends CustomPainter {
  final Shadow shadow;
  final CustomClipper<Path> clipper;

  _ClipShadowShadowPainter({required this.shadow, required this.clipper});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow.toPaint();
    var clipPath = clipper.getClip(size).shift(shadow.offset);
    canvas.drawPath(clipPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class BackgroundWave extends StatelessWidget {
  final double height;

  const BackgroundWave({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;

    return SizedBox(
      height: height,
      child: ClipPath(
        clipper: BackgroundWaveClipper(),
        child: BlurContainer(
          width: MediaQuery.of(context).size.width,
          height: height,
        ),
      ),
    );
  }
}

class BackgroundWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height);

    var firstCurve = Offset(0, size.height - 20);
    var lastCurve = Offset(40, size.height - 20);

    path.quadraticBezierTo(
      firstCurve.dx,
      firstCurve.dy,
      lastCurve.dx,
      lastCurve.dy,
    );

    firstCurve = Offset(0, size.height - 20);
    lastCurve = Offset(size.width - 40, size.height - 20);

    path.quadraticBezierTo(
      firstCurve.dx,
      firstCurve.dy,
      lastCurve.dx,
      lastCurve.dy,
    );

    firstCurve = Offset(size.width, size.height - 20);
    lastCurve = Offset(size.width, size.height);

    path.quadraticBezierTo(
      firstCurve.dx,
      firstCurve.dy,
      lastCurve.dx,
      lastCurve.dy,
    );

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(BackgroundWaveClipper oldClipper) => oldClipper != this;
}

class FSliverAppBar extends SliverPersistentHeaderDelegate {
  final double preferredHeight;
  final Widget child;
  const FSliverAppBar({required this.child, this.preferredHeight = 220});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var adjustedShrinkOffset =
        shrinkOffset > minExtent ? minExtent : shrinkOffset;
    double offset = (minExtent - adjustedShrinkOffset);

    if (offset < 4) {
      offset = 4;
    }

    return Stack(
      children: [
        // const BackgroundWave(
        //   height: preferredHeight,
        // ),
        BlurContainer(
          height: preferredHeight,
        ),
        Positioned(
          top: offset,
          left: 16,
          right: 16,
          child: child,
        )
      ],
    );
  }

  @override
  double get maxExtent => preferredHeight;

  @override
  double get minExtent => preferredHeight / 2;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      oldDelegate.maxExtent != maxExtent || oldDelegate.minExtent != minExtent;
}
