import 'package:flutter/material.dart';
import '../../models/recipe.dart';
import '../widgets/custom_button.dart';

class RecipeDetailPage extends StatefulWidget {
  final Recipe recipe;

  const RecipeDetailPage({super.key, required this.recipe});

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  late int _currentServings;

  @override
  void initState() {
    super.initState();
    _currentServings = widget.recipe.baseServings;
  }

  void _incrementServings() {
    if (_currentServings < 12) {
      setState(() {
        _currentServings++;
      });
    }
  }

  void _decrementServings() {
    if (_currentServings > 1) {
      setState(() {
        _currentServings--;
      });
    }
  }

  void _startCooking() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Starting to cook ${widget.recipe.title} for $_currentServings people!',
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scaledIngredients = widget.recipe.getScaledIngredients(
      _currentServings,
    );
    final scaledTime = widget.recipe.getScaledTime(_currentServings);
    final totalCalories = widget.recipe.getTotalCalories(_currentServings);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FFF9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomButton.iconOnly(
            icon: Icons.arrow_back,
            onPressed: () => Navigator.pop(context),
            backgroundColor: Colors.transparent,
            iconColor: const Color(0xFF2C2C2C),
            size: 40,
            elevation: 0,
          ),
        ),
        title: Text(
          widget.recipe.title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C2C2C),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recipe Image
            Image.asset(
              widget.recipe.image,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    widget.recipe.title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C2C2C),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Serving Size Selector
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.people, color: Color(0xFF4CAF50)),
                          const SizedBox(width: 8),
                          const Text(
                            'Servings:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 16),
                          CustomButton.iconOnly(
                            icon: Icons.remove_circle_outline,
                            onPressed: _decrementServings,
                            backgroundColor: Colors.transparent,
                            iconColor: Colors.red,
                            size: 40,
                            elevation: 0,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '$_currentServings',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          CustomButton.iconOnly(
                            icon: Icons.add_circle_outline,
                            onPressed: _incrementServings,
                            backgroundColor: Colors.transparent,
                            iconColor: Colors.green,
                            size: 40,
                            elevation: 0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Info Cards (Time, Calories)
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoCard(
                          icon: Icons.timer,
                          label: 'Time',
                          value: '$scaledTime min',
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildInfoCard(
                          icon: Icons.local_fire_department,
                          label: 'Calories',
                          value: '$totalCalories kcal',
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Ingredients Section
                  const Text(
                    'Ingredients',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C2C2C),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...scaledIngredients.map((ingredient) {
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            ingredient.image,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(ingredient.name),
                        trailing: Text(
                          '${ingredient.quantity.toStringAsFixed(1)} ${ingredient.unit}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 24),

                  // Start Cooking Button
                  CustomButton.iconText(
                    icon: Icons.restaurant,
                    text: 'Start Cooking',
                    onPressed: _startCooking,
                    backgroundColor: const Color(0xFF4CAF50),
                    textColor: Colors.white,
                    iconColor: Colors.white,
                    width: double.infinity,
                    height: 56,
                    borderRadius: 12,
                    fontSize: 18,
                    elevation: 2,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C2C2C),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
