import 'package:fooder_web/models/product.dart';

class Entry {
  final int id;
  final double grams;
  final Product product;
  final int mealId;
  final double calories;
  final double protein;
  final double fat;
  final double carb;


  const Entry({
    required this.id,
    required this.grams,
    required this.product,
    required this.mealId,
    required this.calories,
    required this.protein,
    required this.fat,
    required this.carb,
  });
}
