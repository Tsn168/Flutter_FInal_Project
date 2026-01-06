import 'ingredient.dart';

class Recipe {
  final String id;
  final String title;
  final List<Ingredient> ingredients;
  final String image;
  final int baseServings;
  final int timeMinutes;
  final String difficulty;
  final int caloriesPerServing;
  final String instructions;

  Recipe({
    required this.id,
    required this.title,
    required this.ingredients,
    required this.image,
    this.baseServings = 2,
    this.timeMinutes = 30,
    this.difficulty = 'Medium',
    this.caloriesPerServing = 300,
    this.instructions = '',
  });

  // Scale ingredient quantities based on target servings
  List<Ingredient> getScaledIngredients(int targetServings) {
    final ratio = targetServings / baseServings;
    return ingredients.map((ingredient) {
      return Ingredient(
        id: ingredient.id,
        name: ingredient.name,
        unit: ingredient.unit,
        quantity: ingredient.quantity * ratio,
        image: ingredient.image,
      );
    }).toList();
  }

  // Scale cooking time logarithmically (time doesn't scale linearly)
  int getScaledTime(int targetServings) {
    final ratio = targetServings / baseServings;
    // Formula: baseTime × (1 + (ratio - 1) × 0.3)
    final scaledTime = timeMinutes * (1 + (ratio - 1) * 0.3);
    return scaledTime.round();
  }

  // Calculate total calories for target servings
  int getTotalCalories(int targetServings) {
    return caloriesPerServing * targetServings;
  }

  // Calculate recipe match percentage based on available ingredients
  double getMatchPercentage(List<String> availableIngredients) {
    if (ingredients.isEmpty) return 0.0;
    
    int matchCount = 0;
    for (var ingredient in ingredients) {
      if (availableIngredients.contains(ingredient.name)) {
        matchCount++;
      }
    }
    
    return (matchCount / ingredients.length) * 100;
  }

  // Convert Recipe to Map for database INSERT
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'base_servings': baseServings,
      'time_minutes': timeMinutes,
      'difficulty': difficulty,
      'calories_per_serving': caloriesPerServing,
      'instructions': instructions,
    };
  }

  // Create Recipe from Map (database SELECT)
  factory Recipe.fromMap(Map<String, dynamic> map, List<Ingredient> ingredients) {
    return Recipe(
      id: map['id'] as String,
      title: map['title'] as String,
      image: map['image'] as String,
      baseServings: map['base_servings'] as int,
      timeMinutes: map['time_minutes'] as int,
      difficulty: map['difficulty'] as String,
      caloriesPerServing: map['calories_per_serving'] as int,
      instructions: map['instructions'] as String,
      ingredients: ingredients,
    );
  }
}
