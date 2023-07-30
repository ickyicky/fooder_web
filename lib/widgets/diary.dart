import 'package:flutter/material.dart';
import 'package:fooder_web/models/diary.dart';
import 'package:fooder_web/widgets/meal.dart';
import 'package:fooder_web/widgets/macro.dart';
import 'package:fooder_web/client.dart';
import 'package:fooder_web/screens/add_meal.dart';
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            expandedHeight: 150,
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
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddMealScreen(
                            apiClient: apiClient,
                            diary: diary,
                          ),
                        ),
                      ).then((_) {
                        refreshParent();
                      });
                    },
                  icon: const Icon(Icons.add),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.secondary),
                    foregroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.onSecondary),
                  ),
                  ),
                ),
              )
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
