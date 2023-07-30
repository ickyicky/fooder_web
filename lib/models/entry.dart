import 'package:fooder/models/product.dart';

class Entry {
  final int id;
  final double grams;
  final Product product;
  final int mealId;
  final double calories;
  final double protein;
  final double fat;
  final double carb;


  Entry({
    required this.id,
    required this.grams,
    required this.product,
    required this.mealId,
    required this.calories,
    required this.protein,
    required this.fat,
    required this.carb,
  });

  Entry.fromJson(Map<String, dynamic> map):
    id = map['id'] as int,
    grams = map['grams'] as double,
    product = Product.fromJson(map['product'] as Map<String, dynamic>),
    mealId = map['meal_id'] as int,
    calories = map['calories'] as double,
    protein = map['protein'] as double,
    fat = map['fat'] as double,
    carb = map['carb'] as double;
}
