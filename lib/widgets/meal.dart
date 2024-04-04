import 'package:flutter/material.dart';
import 'package:fooder/models/meal.dart';
import 'package:fooder/widgets/entry.dart';
import 'package:fooder/widgets/macro.dart';
import 'package:fooder/screens/edit_entry.dart';
import 'package:fooder/client.dart';
import 'dart:core';

class MealHeader extends StatelessWidget {
  final Meal meal;

  const MealHeader({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              meal.name,
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

class MealWidget extends StatelessWidget {
  static const maxWidth = 920.0;

  final Meal meal;
  final ApiClient apiClient;
  final Function() refreshParent;
  final Function(String) showText;
  final bool initiallyExpanded;

  const MealWidget({
    super.key,
    required this.meal,
    required this.apiClient,
    required this.refreshParent,
    required this.initiallyExpanded,
    required this.showText,
  });

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
                showText("Meal saved");
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteMeal(Meal meal) async {
    await apiClient.deleteMeal(meal.id);
  }

  Future<void> deleteMeal(context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
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
                _deleteMeal(meal).then((_) => refreshParent());
                Navigator.pop(context);
                showText("Meal deleted");
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _editEntry(context, entry) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditEntryScreen(
          apiClient: apiClient,
          entry: entry,
        ),
      ),
    ).then((_) => refreshParent());
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;

    var widthAvail = MediaQuery.of(context).size.width;
    var width = widthAvail > maxWidth ? maxWidth : widthAvail;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Container(
            constraints: BoxConstraints(maxWidth: width),
            color: colorScheme.surface.withOpacity(0.2),
            child: ExpansionTile(
              iconColor: colorScheme.onSurface,
              collapsedIconColor: colorScheme.onSurface,
              initiallyExpanded: initiallyExpanded,
              enableFeedback: true,
              title: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    MealHeader(meal: meal),
                    const MacroHeaderWidget(
                      calories: true,
                    ),
                    MacroEntryWidget(
                      protein: meal.protein,
                      carb: meal.carb,
                      fat: meal.fat,
                      calories: meal.calories,
                    ),
                  ],
                ),
              ),
              children: <Widget>[
                for (var (i, entry) in meal.entries.indexed)
                  ListTile(
                    title: EntryWidget(
                      entry: entry,
                    ),
                    tileColor: i % 2 == 0
                        ? colorScheme.surfaceVariant.withOpacity(0.1)
                        : Colors.transparent,
                    onTap: () => _editEntry(context, entry),
                    enableFeedback: true,
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.save),
                      onPressed: () => saveMeal(context),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => deleteMeal(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
