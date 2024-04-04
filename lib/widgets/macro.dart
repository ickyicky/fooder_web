import 'package:flutter/material.dart';
import 'dart:core';

class MacroHeaderWidget extends StatelessWidget {
  static const double padY = 4;
  static const double padX = 8;

  final bool? fiber;
  final bool? calories;
  final Alignment alignment;

  const MacroHeaderWidget({
    super.key,
    this.fiber = false,
    this.calories = false,
    this.alignment = Alignment.centerLeft,
  });

  @override
  Widget build(BuildContext context) {
    var elements = <String>[
      "C(g)",
      "F(g)",
      "P(g)",
    ];

    if (fiber == true) {
      elements.add(
        "f(g)",
      );
    }

    if (calories == true) {
      elements.add(
        "kcal",
      );
    }

    var children = <Widget>[];

    if (alignment == Alignment.centerRight) {
      children.add(const Spacer());
    }

    for (var element in elements) {
      children.add(
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 2,
          ),
          child: SizedBox(
            width: 55,
            child: Text(
              element,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    if (alignment == Alignment.centerLeft) {
      children.add(const Spacer());
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: padY,
        horizontal: padX,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: children,
      ),
    );
  }
}

class MacroEntryWidget extends StatelessWidget {
  static const double padY = 4;
  static const double padX = 8;

  final double protein;
  final double carb;
  final double fat;
  final double? fiber;
  final double? calories;
  final Alignment alignment;

  const MacroEntryWidget({
    super.key,
    required this.protein,
    required this.carb,
    required this.fat,
    this.fiber,
    this.calories,
    this.alignment = Alignment.centerLeft,
  });

  @override
  Widget build(BuildContext context) {
    var elements = <String>[
      (carb.toStringAsFixed(1)),
      (fat.toStringAsFixed(1)),
      (protein.toStringAsFixed(1)),
    ];

    if (fiber != null) {
      elements.add(
        fiber!.toStringAsFixed(1),
      );
    }

    if (calories != null) {
      elements.add(
        calories!.toStringAsFixed(0),
      );
    }

    var children = <Widget>[];

    if (alignment == Alignment.centerRight) {
      children.add(const Spacer());
    }

    for (var element in elements) {
      children.add(
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 2,
          ),
          child: SizedBox(
            width: 55,
            child: Text(
              element,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    if (alignment == Alignment.centerLeft) {
      children.add(const Spacer());
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: padY,
        horizontal: padX,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: children,
      ),
    );
  }
}
