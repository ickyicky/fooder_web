import 'package:flutter/material.dart';
import 'package:fooder/models/entry.dart';
import 'package:fooder/widgets/macro.dart';
import 'dart:core';

class EntryHeader extends StatelessWidget {
  final Entry entry;

  const EntryHeader({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              entry.product.name,
              overflow: TextOverflow.fade,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            "${entry.grams.toStringAsFixed(0)} g",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
        ),
      ],
    );
  }
}

class EntryWidget extends StatelessWidget {
  final Entry entry;

  const EntryWidget({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          EntryHeader(entry: entry),
          MacroEntryWidget(
            protein: entry.protein,
            carb: entry.carb,
            fat: entry.fat,
            calories: entry.calories,
          ),
        ],
      ),
    );
  }
}
