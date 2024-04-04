import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fooder/components/blur_container.dart';

class FNavBar extends StatelessWidget {
  static const maxWidth = 920.0;

  final List<Widget> children;
  final double height;

  const FNavBar({super.key, required this.children, this.height = 78});

  @override
  Widget build(BuildContext context) {
    var widthAvail = MediaQuery.of(context).size.width;
    // var width = widthAvail > maxWidth ? maxWidth : widthAvail;
    return SizedBox(
      width: widthAvail,
      height: height * children.length,
      child: BlurContainer(
        width: widthAvail,
        height: height * children.length,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ...children,
          Container(
            height: height / 3,
            color: Colors.transparent,
          ),
        ]),
      ),
    );
  }
}
