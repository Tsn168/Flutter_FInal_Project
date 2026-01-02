import 'ingredient.dart';

class Recipe {
  final String id;
  final String title;
  final List<Ingredient> ingredients;
  final String steps; // Can be a long text describing cooking steps

  Recipe({
    required this.id,
    required this.title,
    required this.ingredients,
    required this.steps,
  });
}
