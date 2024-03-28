import 'package:flutter/material.dart';

class FButton extends StatelessWidget {
  final String labelText;
  final double padding;
  final double insidePadding;
  final double fontSize;
  final Function()? onPressed;

  const FButton({super.key, required this.labelText, this.padding = 8, this.insidePadding = 24, this.fontSize = 20, this.onPressed});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: padding, horizontal: padding),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: insidePadding),
          decoration: BoxDecoration(
            color: colorScheme.primary,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              labelText,
              style: theme.textTheme.button!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
              ),
            ),
          ),
        ),
      )
    );
  }
}
