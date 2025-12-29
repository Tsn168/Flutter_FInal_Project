import 'ingredient.dart';

class Recipe {
  final String id;
  final String title;
  final List<Ingredient> ingredients;

  const Recipe({
    required this.id,
    required this.title,
    this.ingredients = const [],
  });
}
