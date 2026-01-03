import 'ingredient.dart';

class Recipe {
  final String id;
  final String title;
  final List<Ingredient> ingredients;
  final String image;

  Recipe({
    required this.id,
    required this.title,
    required this.ingredients,
    required this.image,
  });
}
