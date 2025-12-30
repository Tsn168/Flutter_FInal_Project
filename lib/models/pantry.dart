import 'ingredient.dart';

class Pantry {
  final String id;
  final String name; // e.g., "Home Pantry"
  final List<Ingredient> ingredients;

  Pantry({required this.id, required this.name, this.ingredients = const []});
}
