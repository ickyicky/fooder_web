import 'package:flutter/material.dart';
import 'dart:core';


class MacroHeaderWidget extends StatelessWidget {
  static final double PAD_Y = 4;
  static final double PAD_X = 8;

  final bool? fiber;
  final bool? calories;

  const MacroHeaderWidget(
    {
      super.key,
      this.fiber = false,
      this.calories = false,
    }
  );


  @override
  Widget build(BuildContext context) {
    var elements = <String>[
      "C(g)",
      "F(g)",
      "P(g)",
    ];

    if (fiber == true) {
      elements.add(
        "F(g)",
      );
    }

    if (calories == true) {
      elements.add(
        "kcal",
      );
    }

    var children = <Widget>[];

    for (var element in elements) {
      children.add(
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 2,
          ),
          child: SizedBox(
            width: 55,
            child: Text(
              element,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    children.add(Spacer());

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: PAD_Y,
        horizontal: PAD_X,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: children,
      ),
    );
  }
}


class MacroEntryWidget extends StatelessWidget {
  static final double PAD_Y = 4;
  static final double PAD_X = 8;

  final double protein;
  final double carb;
  final double fat;
  final double? fiber;
  final double? calories;

  const MacroEntryWidget(
    {
      super.key,
      required this.protein,
      required this.carb,
      required this.fat,
      this.fiber,
      this.calories,
    }
  );


  @override
  Widget build(BuildContext context) {
    var elements = <String>[
      "${carb.toStringAsFixed(1)}",
      "${fat.toStringAsFixed(1)}",
      "${protein.toStringAsFixed(1)}",
    ];

    if (fiber != null) {
      elements.add(
        "${fiber!.toStringAsFixed(1)}",
      );
    }

    if (calories != null) {
      elements.add(
        "${calories!.toStringAsFixed(0)}",
      );
    }

    var children = <Widget>[];

    for (var element in elements) {
      children.add(
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 2,
          ),
          child: SizedBox(
            width: 55,
            child: Text(
              element,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    children.add(Spacer());

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: PAD_Y,
        horizontal: PAD_X,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: children,
      ),
    );
  }
}
