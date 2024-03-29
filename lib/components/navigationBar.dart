import 'package:flutter/material.dart';
import 'package:blur/blur.dart';

class FNavBar extends StatelessWidget  {
  final List<Widget> children;
  final double height;

  const FNavBar ({super.key, required this.children, this.height = 56});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: colorScheme.primary.withOpacity(0.3),
                blurRadius: 5,
                offset: const Offset(0, 5),
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              children: [
                Blur(
                  blur: 10,
                  blurColor: colorScheme.primary.withOpacity(0.1),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: height * children.length,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          colorScheme.primary.withOpacity(0.1),
                          colorScheme.secondary.withOpacity(0.1),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: height * children.length,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: children,
                  ),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}
