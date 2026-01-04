import 'package:flutter/material.dart';
import '../../models/recipe.dart';
import '../../data/dummy/dummy_recipe.dart';
import 'recipe_detail_page.dart';

class RecipeListPage extends StatelessWidget {
  final List<String> availableIngredients;

  const RecipeListPage({
    super.key,
    required this.availableIngredients,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate match percentage for each recipe and sort
    final recipesWithMatch = dummyRecipes.map((recipe) {
      final matchPercentage = recipe.getMatchPercentage(availableIngredients);
      return {'recipe': recipe, 'match': matchPercentage};
    }).toList();

    // Sort by match percentage (highest first)
    recipesWithMatch.sort((a, b) => (b['match'] as double).compareTo(a['match'] as double));

    return Scaffold(
      backgroundColor: const Color(0xFFF8FFF9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2C2C2C)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Recipe Matches',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C2C2C),
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: recipesWithMatch.length,
        itemBuilder: (context, index) {
          final item = recipesWithMatch[index];
          final recipe = item['recipe'] as Recipe;
          final matchPercentage = item['match'] as double;
          
          // Calculate matched ingredients count
          int matchedCount = 0;
          for (var ingredient in recipe.ingredients) {
            if (availableIngredients.contains(ingredient.name)) {
              matchedCount++;
            }
          }
          
          // Determine match status
          Color matchColor;
          String matchLabel;
          IconData matchIcon;
          
          if (matchPercentage == 100) {
            matchColor = Colors.green;
            matchLabel = 'Perfect Match';
            matchIcon = Icons.check_circle;
          } else if (matchPercentage >= 50) {
            matchColor = Colors.orange;
            matchLabel = 'Partial Match';
            matchIcon = Icons.info;
          } else {
            matchColor = Colors.red;
            matchLabel = 'Low Match';
            matchIcon = Icons.warning;
          }
          
          return Card(
            color: const Color(0xFFFDFDFD),
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecipeDetailPage(recipe: recipe),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(14),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    // Recipe image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        recipe.image,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    
                    // Recipe info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            recipe.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Color(0xFF2C2C2C),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(matchIcon, size: 16, color: matchColor),
                              const SizedBox(width: 4),
                              Text(
                                matchLabel,
                                style: TextStyle(
                                  color: matchColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '$matchedCount/${recipe.ingredients.length} ingredients',
                            style: const TextStyle(
                              color: Color(0xFF6F6F6F),
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 14,
                                color: Colors.grey[600],
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${recipe.timeMinutes} min',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Icon(
                                Icons.signal_cellular_alt,
                                size: 14,
                                color: Colors.grey[600],
                              ),
                              const SizedBox(width: 4),
                              Text(
                                recipe.difficulty,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    // Match percentage
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: matchColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${matchPercentage.toInt()}%',
                        style: TextStyle(
                          color: matchColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
