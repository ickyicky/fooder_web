import 'package:flutter/material.dart';
import 'package:fooder/models/preset.dart';
import 'package:fooder/widgets/macro.dart';
import 'dart:core';

class PresetHeader extends StatelessWidget {
  final String title;

  const PresetHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              title,
              overflow: TextOverflow.fade,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}

class PresetWidget extends StatelessWidget {
  final Preset preset;

  const PresetWidget({super.key, required this.preset});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          PresetHeader(
            title: preset.name,
          ),
          const MacroHeaderWidget(
            fiber: true,
            calories: true,
            alignment: Alignment.center,
          ),
          MacroEntryWidget(
            protein: preset.protein,
            carb: preset.carb,
            fat: preset.fat,
            fiber: preset.fiber,
            calories: preset.calories,
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }
}
