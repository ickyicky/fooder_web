import 'package:flutter/material.dart';
import 'package:fooder_web/models/meal.dart';
import 'package:fooder_web/widgets/entry.dart';
import 'package:fooder_web/widgets/macro.dart';
import 'package:fooder_web/screens/edit_entry.dart';
import 'package:fooder_web/client.dart';
import 'dart:core';


class MealWidget extends StatelessWidget {
  final Meal meal;
  final ApiClient apiClient;
  final Function() refreshParent;

  const MealWidget({super.key, required this.meal, required this.apiClient, required this.refreshParent});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
       padding: const EdgeInsets.only(
          top: 36.0, left: 6.0, right: 6.0, bottom: 6.0),
          child: ExpansionTile(
            title: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        meal.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Text("${meal.calories.toStringAsFixed(1)} kcal"),
                  ],
                ),
                MacroWidget(
                  protein: meal.protein,
                  carb: meal.carb,
                  fat: meal.fat,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
            children: <Widget>[
              for (var entry in meal.entries)
                ListTile(
                  title: EntryWidget(
                    entry: entry,
                  ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditEntryScreen(
                        apiClient: apiClient,
                        entry: entry,
                      ),
                    ),
                  ).then((_) {
                    refreshParent();
                  });
                },
                )
          ],
        ),
      ),
    );
  }
}
