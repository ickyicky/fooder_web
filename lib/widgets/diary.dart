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
            Text(diary.date.toString()),
        ],
      ),
    );
  }
}
