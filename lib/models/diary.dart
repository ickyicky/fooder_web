import 'package:fooder/models/meal.dart';


class Diary {
  final int id;
  final DateTime date;
  final List<Meal> meals;
  final double calories;
  final double protein;
  final double carb;
  final double fat;
  final double fiber;

  Diary({
    required this.id,
    required this.date,
    required this.meals,
    required this.calories,
    required this.protein,
    required this.carb,
    required this.fat,
    required this.fiber,
  });

  Diary.fromJson(Map<String, dynamic> map):
    id = map['id'] as int,
    date = DateTime.parse(map['date']),
    meals = (map['meals'] as List<dynamic>).map((e) => Meal.fromJson(e as Map<String, dynamic>)).toList(),
    calories = map['calories'] as double,
    protein = map['protein'] as double,
    carb = map['carb'] as double,
    fat = map['fat'] as double,
    fiber = map['fiber'] as double;
}
