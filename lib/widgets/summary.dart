import 'package:flutter/material.dart';
import 'package:fooder/models/diary.dart';
import 'package:fooder/widgets/macroEntry.dart';
import 'package:fooder/screens/add_meal.dart';
import 'package:fooder/client.dart';
import 'dart:core';


class SummaryHeader extends StatelessWidget {
  final Diary diary;
  final Function addMeal;

  const SummaryHeader(
      {super.key,
      required this.addMeal,
      required this.diary});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            "Summary",
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: IconButton(
            icon: Icon(Icons.playlist_add_rounded),
            iconSize: 32,
            color: Theme.of(context).colorScheme.onPrimary,
            onPressed: () => addMeal(context),
          ),
        ),
      ],
    );
  }
}


class SummaryWidget extends StatelessWidget {
  static final MAX_WIDTH = 920.0;

  final Diary diary;
  final ApiClient apiClient;
  final Function() refreshParent;

  const SummaryWidget(
      {super.key,
      required this.diary,
      required this.apiClient,
      required this.refreshParent});

  Future<void> _addMeal(context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddMealScreen(
          apiClient: apiClient,
          diary: diary,
        ),
      ),
    ).then((_) => refreshParent());
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;

    var width_avail = MediaQuery.of(context).size.width;
    var width = width_avail > MAX_WIDTH ? MAX_WIDTH : width_avail;

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
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                child: Column(
                  children: <Widget>[
                    SummaryHeader(diary: diary, addMeal: _addMeal),
                    MacroHeaderWidget(
                      calories: true,
                    ),
                    MacroEntryWidget(
                      protein: diary.protein,
                      carb: diary.carb,
                      fat: diary.fat,
                      calories: diary.calories,
                    ),
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
