class Preset {
  final int id;
  final String name;
  final double calories;
  final double protein;
  final double carb;
  final double fat;
  final double fiber;

  Preset({
    required this.id,
    required this.name,
    required this.calories,
    required this.protein,
    required this.carb,
    required this.fat,
    required this.fiber,
  });

  Preset.fromJson(Map<String, dynamic> map)
      : id = map['id'] as int,
        name = map['name'] as String,
        calories = map['calories'] as double,
        protein = map['protein'] as double,
        carb = map['carb'] as double,
        fat = map['fat'] as double,
        fiber = map['fiber'] as double;
}
