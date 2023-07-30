import 'package:flutter/material.dart';
import 'package:fooder_web/models/entry.dart';
import 'package:fooder_web/widgets/macro.dart';
import 'dart:core';


class EntryWidget extends StatelessWidget {
  final Entry entry;

  const EntryWidget({super.key, required this.entry});

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
                  entry.product.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Text("${entry.calories.toStringAsFixed(1)} kcal"),
            ],
          ),
          MacroWidget(
            protein: entry.protein,
            carb: entry.carb,
            fat: entry.fat,
            amount: entry.grams,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
