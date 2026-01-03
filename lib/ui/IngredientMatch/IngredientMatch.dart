import 'package:flutter/material.dart';
import '../../models/ingredient.dart';
import '../../data/dummy/dummy_recipe.dart';

class IngredientMatchPage extends StatelessWidget {
  final Ingredient ingredient;

  const IngredientMatchPage({super.key, required this.ingredient});

  @override
  Widget build(BuildContext context) {
    final matchedRecipes = dummyRecipes.where((recipe) {
      return recipe.ingredients.any(
        (i) => i.name.toLowerCase() == ingredient.name.toLowerCase(),
      );
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FFF9),
      appBar: AppBar(
        title: Text(
          'Recipes with ${ingredient.name}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF4CAF50),
        elevation: 0,
      ),
      body: matchedRecipes.isEmpty
          ? const Center(
              child: Text(
                'No matching recipes found',
                style: TextStyle(fontSize: 16, color: Color(0xFF6F6F6F)),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: ListView.builder(
                itemCount: matchedRecipes.length,
                itemBuilder: (context, index) {
                  final recipe = matchedRecipes[index];
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Recipe Image
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: Image.asset(
                            recipe.image,
                            width: double.infinity,
                            height: 180,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: double.infinity,
                                height: 180,
                                color: Colors.grey.shade200,
                                child: const Icon(
                                  Icons.image_not_supported,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                              );
                            },
                          ),
                        ),

                        // Recipe Details
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Recipe Title
                              Text(
                                recipe.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2C2C2C),
                                ),
                              ),
                              const SizedBox(height: 8),

                              // Ingredients List
                              Text(
                                'Ingredients:',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                recipe.ingredients
                                    .map(
                                      (i) =>
                                          '${i.name} (${i.quantity} ${i.unit})',
                                    )
                                    .join(', '),
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF6F6F6F),
                                ),
                              ),
                              const SizedBox(height: 12),

                              // View Recipe Button
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Navigate to recipe detail page
                                    // You can implement this later
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Opening ${recipe.title} recipe...',
                                        ),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF4CAF50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    'View Recipe',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}
