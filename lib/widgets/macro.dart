import 'package:flutter/material.dart';


class MacroWidget extends StatelessWidget {
  final double? amount;
  final double? calories;
  final double protein;
  final double carb;
  final double fat;
  final TextStyle style;

  const MacroWidget({
    Key? key,
    this.calories,
    this.amount,
    required this.protein,
    required this.carb,
    required this.fat,
    required this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var elements = <Widget>[
    Expanded(
      flex: 1,
      child: Text(
        "C: ${carb.toStringAsFixed(1)}g",
        style: style,
        textAlign: TextAlign.center,
        ),
      ),
    Expanded(
      flex: 1,
      child: Text(
        "F: ${fat.toStringAsFixed(1)}g",
        style: style,
        textAlign: TextAlign.center,
        ),
      ),
    Expanded(
      flex: 1,
      child: Text(
        "P: ${protein.toStringAsFixed(1)}g",
        style: style,
        textAlign: TextAlign.center,
        ),
      ),
    ];

    if (calories != null) {
      elements.add(
        Expanded(
          flex: 1,
          child: Text(
            "${calories!.toStringAsFixed(1)} kcal",
            style: style,
            textAlign: TextAlign.center,
            ),
          ),
        );
    }

    if (amount != null) {
      elements.add(
        Expanded(
          flex: 1,
          child: Text(
            "${amount!.toStringAsFixed(1)}g",
            style: style,
            textAlign: TextAlign.center,
            ),
          ),
        );
    }

    if (amount == null && calories == null) {
      elements.add(
        Expanded(
          flex: 1,
          child: Text(
            "",
            style: style,
            textAlign: TextAlign.center,
            ),
          ),
        );
    }

    return Padding(
      padding: const EdgeInsets.only(
        top: 4.0,
        bottom: 4.0,
        left: 8.0,
        right: 8.0,
      ),
      child: Row(
        children: elements,
      ),
    );
  }
}
