import 'package:flutter/material.dart';
import '../../models/ingredient.dart';
import '../../models/recipe.dart';
import '../../data/dummy/dummy_recipe.dart';

class IngredientMatchPage extends StatelessWidget {
  final Ingredient ingredient;

  const IngredientMatchPage({super.key, required this.ingredient});

  @override
  Widget build(BuildContext context) {
    // Filter recipes that contain this ingredient
    final matchedRecipes = dummyRecipes.where((recipe) {
      return recipe.ingredients.any(
        (i) => i.name.toLowerCase() == ingredient.name.toLowerCase(),
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Recipes with ${ingredient.name}'),
        backgroundColor: Colors.green,
      ),
      body: matchedRecipes.isEmpty
          ? const Center(child: Text('No matching recipes found'))
          : ListView.builder(
              itemCount: matchedRecipes.length,
              itemBuilder: (context, index) {
                final recipe = matchedRecipes[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(recipe.title),
                    subtitle: Text(
                      recipe.ingredients
                          .map((i) => '${i.name} (${i.quantity} ${i.unit})')
                          .join(', '),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
