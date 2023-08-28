import 'package:flutter/material.dart';

class MacroWidget extends StatelessWidget {
  final double? amount;
  final double? calories;
  final double? fiber;
  final double protein;
  final double carb;
  final double fat;
  final TextStyle style;
  final Widget? child;

  const MacroWidget({
    Key? key,
    this.calories,
    this.amount,
    this.child,
    this.fiber,
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

    if (fiber != null) {
      elements.add(
        Expanded(
          flex: 1,
          child: Text(
            "f: ${fiber!.toStringAsFixed(1)}g",
            style: style,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

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

    if (child != null) {
      elements.add(
        Expanded(
          flex: 1,
          child: child!,
        ),
      );
    }

    if (elements.length < 4) {
      elements.add(
        const Expanded(
          flex: 1,
          child: Text(""),
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
