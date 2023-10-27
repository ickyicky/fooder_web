import 'package:flutter/material.dart';
import 'package:fooder/models/preset.dart';
import 'package:fooder/widgets/macro.dart';
import 'dart:core';

class PresetWidget extends StatelessWidget {
  final Preset preset;

  const PresetWidget({super.key, required this.preset});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  preset.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Text("${preset.calories.toStringAsFixed(1)} kcal"),
            ],
          ),
          MacroWidget(
            protein: preset.protein,
            carb: preset.carb,
            fat: preset.fat,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
          ),
        ],
      ),
    );
  }
}
