import 'package:flutter/material.dart';

class BackgroundWave extends StatelessWidget {
  final double height;

  const BackgroundWave({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;

    return SizedBox(
      height: height,
      child: ClipPath(
          clipper: BackgroundWaveClipper(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [colorScheme.primary, colorScheme.secondary],
            )),
          )),
    );
  }
}

class BackgroundWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height);

    var firstCurve = Offset(0, size.height - 20);
    var lastCurve = Offset(30, size.height - 20);

    path.quadraticBezierTo(
        firstCurve.dx, firstCurve.dy, lastCurve.dx, lastCurve.dy,
    );

    firstCurve = Offset(0, size.height - 20);
    lastCurve = Offset(size.width - 30, size.height - 20);

    path.quadraticBezierTo(
        firstCurve.dx, firstCurve.dy, lastCurve.dx, lastCurve.dy,
    );

    firstCurve = Offset(size.width, size.height - 20);
    lastCurve = Offset(size.width, size.height);

    path.quadraticBezierTo(
        firstCurve.dx, firstCurve.dy, lastCurve.dx, lastCurve.dy,
    );

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(BackgroundWaveClipper oldClipper) => oldClipper != this;
}

class FSliverAppBar extends SliverPersistentHeaderDelegate {
  final Widget child;
  const FSliverAppBar({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    var adjustedShrinkOffset = shrinkOffset > minExtent ? minExtent : shrinkOffset;
    double offset = (minExtent - adjustedShrinkOffset);

    return Stack(
      children: [
        const BackgroundWave(
          height: 280,
        ),
        Positioned(
          top: offset + 8,
          child: child,
          left: 16,
          right: 16,
        )
      ],
    );
  }

  @override
  double get maxExtent => 280;

  @override
  double get minExtent => 140;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      oldDelegate.maxExtent != maxExtent || oldDelegate.minExtent != minExtent;
}
