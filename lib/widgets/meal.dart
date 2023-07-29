import 'package:flutter/material.dart';
import 'package:fooder_web/models/meal.dart';
import 'package:fooder_web/widgets/entry.dart';
import 'dart:core';


class MealWidget extends StatelessWidget {
  final Meal meal;

  const MealWidget({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
       padding: const EdgeInsets.only(
          top: 36.0, left: 6.0, right: 6.0, bottom: 6.0),
          child: ExpansionTile(
          title: const Text('SEKS Z KOBIETA'),
          children: <Widget>[
            for (var entry in meal.entries)
              EntryWidget(
                entry: entry,
                ),
          ],
        ),
      ),
    );
  }
}
