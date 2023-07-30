import 'package:flutter/material.dart';
import 'package:fooder_web/models/diary.dart';
import 'package:fooder_web/widgets/meal.dart';
import 'package:fooder_web/widgets/macro.dart';
import 'package:fooder_web/client.dart';
import 'dart:core';


class DiaryWidget extends StatelessWidget {
  final Diary diary;
  final ApiClient apiClient;
  final Function() refreshParent;

  const DiaryWidget({super.key, required this.diary, required this.apiClient, required this.refreshParent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Row(
              children: <Widget>[
                const Spacer(),
                Text(
                  "${diary.calories.toStringAsFixed(1)} kcal",
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSecondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]
            ),
            expandedHeight: 128,
            backgroundColor: Theme.of(context).colorScheme.secondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: MacroWidget(
                protein: diary.protein,
                carb: diary.carb,
                fat: diary.fat,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                for (var meal in diary.meals)
                  MealWidget(
                    meal: meal,
                    apiClient: apiClient,
                    refreshParent: refreshParent,
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
