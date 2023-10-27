import 'package:flutter/material.dart';
import 'package:fooder/models/meal.dart';
import 'package:fooder/widgets/entry.dart';
import 'package:fooder/widgets/macro.dart';
import 'package:fooder/screens/edit_entry.dart';
import 'package:fooder/client.dart';
import 'dart:core';

class MealWidget extends StatelessWidget {
  final Meal meal;
  final ApiClient apiClient;
  final Function() refreshParent;

  const MealWidget(
      {super.key,
      required this.meal,
      required this.apiClient,
      required this.refreshParent});

  Future<void> saveMeal(context) async {
    TextEditingController textFieldController = TextEditingController();
    textFieldController.text = meal.name;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Save Meal'),
          content: TextField(
            controller: textFieldController,
            decoration: const InputDecoration(hintText: "Meal template name"),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.cancel),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                apiClient.saveMeal(meal, textFieldController.text);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteMeal(Meal meal) async {
    await apiClient.deleteMeal(meal.id);
    refreshParent();
  }

  Future<void> deleteMeal(context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm deletion of the meal'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.cancel),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                _deleteMeal(meal);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

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
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {deleteMeal(context);},
                  ),
                  IconButton(
                    icon: const Icon(Icons.save),
                    onPressed: () {saveMeal(context);},
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
