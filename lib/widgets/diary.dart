import 'package:flutter/material.dart';
import 'package:fooder_web/models/diary.dart';
import 'package:fooder_web/widgets/meal.dart';
import 'dart:core';


class DiaryWidget extends StatelessWidget {
  final Diary diary;

  const DiaryWidget({super.key, required this.diary});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          for (var meal in diary.meals)
            MealWidget(
              meal: meal,
              ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "carb: ${diary.carb.toStringAsFixed(2)}",
                        style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                      ),
                      Text(
                        "fat: ${diary.fat.toStringAsFixed(2)}",
                        style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                      ),
                      Text(
                        "protein: ${diary.protein.toStringAsFixed(2)}",
                        style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                      ),
                      Text(
                        "calories: ${diary.calories.toStringAsFixed(2)}",
                        style: TextStyle(color: Theme.of(context).colorScheme.primary),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
