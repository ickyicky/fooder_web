import 'package:flutter/material.dart';
import 'package:fooder/components/blur_container.dart';

class FActionButton extends StatelessWidget {
  final IconData icon;
  final Function() onPressed;
  final String tag;

  const FActionButton(
      {super.key,
      required this.icon,
      required this.onPressed,
      this.tag = 'fap'});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;

    return Container(
      height: 64,
      width: 64,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BlurContainer(
          height: 64,
          width: 64,
          child: SizedBox(
            height: 64,
            width: 64,
            child: FloatingActionButton(
              elevation: 0,
              onPressed: onPressed,
              heroTag: tag,
              backgroundColor: Colors.transparent,
              child: Icon(
                icon,
                color: colorScheme.onSurface,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
