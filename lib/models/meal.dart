import 'package:fooder_web/models/entry.dart';


class Meal {
  final List<Entry> entries;
  final int id;
  final String name;
  final int order;
  final double calories;
  final double protein;
  final double carb;
  final double fat;
  final int diaryId;

  Meal({
    required this.entries,
    required this.id,
    required this.name,
    required this.order,
    required this.calories,
    required this.protein,
    required this.carb,
    required this.fat,
    required this.diaryId,
  });

  Meal.fromJson(Map<String, dynamic> map):
    entries = (map['entries'] as List<dynamic>).map((e) => Entry.fromJson(e as Map<String, dynamic>)).toList(),
    id = map['id'] as int,
    name = map['name'] as String,
    order = map['order'] as int,
    calories = map['calories'] as double,
    protein = map['protein'] as double,
    carb = map['carb'] as double,
    fat = map['fat'] as double,
    diaryId = map['diary_id'] as int;
}
