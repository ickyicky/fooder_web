import 'package:fooder_web/models/meal.dart';


class Diary {
  final int id;
  final DateTime date;
  final List<Meal> meals;
  final double calories;
  final double protein;
  final double carb;
  final double fat;

  Diary({
    required this.id,
    required this.date,
    required this.meals,
    required this.calories,
    required this.protein,
    required this.carb,
    required this.fat,
  });

  Diary.fromJson(Map<String, dynamic> map):
    id = map['id'] as int,
    date = DateTime.parse(map['date']),
    meals = <Meal>[],
    calories = map['calories'] as double,
    protein = map['protein'] as double,
    carb = map['carb'] as double,
    fat = map['fat'] as double;
}
