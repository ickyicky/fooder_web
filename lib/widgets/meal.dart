import 'package:flutter/material.dart';
import 'package:fooder/models/meal.dart';
import 'package:fooder/widgets/entry.dart';
import 'package:fooder/widgets/macroEntry.dart';
import 'package:fooder/screens/edit_entry.dart';
import 'package:fooder/screens/meal.dart';
import 'package:fooder/client.dart';
import 'dart:core';

class MealHeader extends StatelessWidget {
  final Meal meal;

  const MealHeader({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            meal.name,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
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
  final bool initiallyExpanded;

  const MealWidget({
    super.key,
    required this.meal,
    required this.apiClient,
    required this.refreshParent,
    required this.initiallyExpanded,
  });

  Future<void> _editMeal(context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MealScreen(
          apiClient: apiClient,
          meal: meal,
          refresh: refreshParent,
        ),
      ),
    ).then((_) => refreshParent());
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
          elevation: 4,
          clipBehavior: Clip.antiAlias,
          shadowColor: colorScheme.primary.withOpacity(1.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: SizedBox(
            width: width,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    colorScheme.primary.withOpacity(0.6),
                    colorScheme.secondary.withOpacity(0.5),
                  ],
                ),
              ),
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onLongPress: () => _editMeal(context),
                child: ExpansionTile(
                  iconColor: colorScheme.onPrimary,
                  collapsedIconColor: colorScheme.onPrimary,
                  initiallyExpanded: initiallyExpanded,
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
                            ? colorScheme.secondary.withOpacity(0.1)
                            : Colors.transparent,
                        onTap: () => _editEntry(context, entry),
                      )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
