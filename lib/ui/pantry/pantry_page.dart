import 'package:flutter/material.dart';
import '../../data/dummy/dummy_ingredient.dart';
import '../../models/ingredient.dart';
import '../IngredientMatch/IngredientMatch.dart';

class PantryPage extends StatefulWidget {
  const PantryPage({super.key});

  @override
  State<PantryPage> createState() => _PantryPageState();
}

class _PantryPageState extends State<PantryPage> {
  late List<Ingredient> _ingredients;

  // All available predefined ingredients
  final List<Ingredient> _allAvailableIngredients = [
    eggs,
    milk,
    butter,
    flour,
    sugar,
    chicken,
    tomato,
    cream,
    pasta,
    carrot,
  ];

  @override
  void initState() {
    super.initState();
    // Start with some ingredients in pantry
    _ingredients = [eggs, milk, butter, flour];
  }

  void _showEditIngredientsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        // Create a map to track quantities for all ingredients
        Map<String, double> ingredientQuantities = {};

        // Initialize with current pantry quantities
        for (var ingredient in _ingredients) {
          ingredientQuantities[ingredient.id] = ingredient.quantity;
        }

        // Initialize missing ingredients with 0
        for (var ingredient in _allAvailableIngredients) {
          if (!ingredientQuantities.containsKey(ingredient.id)) {
            ingredientQuantities[ingredient.id] = 0;
          }
        }

        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Edit Pantry Ingredients'),
              content: SizedBox(
                width: double.maxFinite,
                height: 400,
                child: ListView.builder(
                  itemCount: _allAvailableIngredients.length,
                  itemBuilder: (context, index) {
                    final ingredient = _allAvailableIngredients[index];
                    final currentQuantity =
                        ingredientQuantities[ingredient.id] ?? 0;

                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            // Ingredient image
                            Image.asset(
                              ingredient.image,
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 12),

                            // Ingredient name and unit
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ingredient.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    ingredient.unit,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Quantity controls
                            Row(
                              children: [
                                // Decrease button
                                IconButton(
                                  onPressed: currentQuantity > 0
                                      ? () {
                                          setDialogState(() {
                                            ingredientQuantities[ingredient
                                                    .id] =
                                                currentQuantity - 1;
                                          });
                                        }
                                      : null,
                                  icon: const Icon(
                                    Icons.remove_circle_outline,
                                    color: Colors.red,
                                  ),
                                ),

                                // Quantity display
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    currentQuantity.toInt().toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),

                                // Increase button
                                IconButton(
                                  onPressed: () {
                                    setDialogState(() {
                                      ingredientQuantities[ingredient.id] =
                                          currentQuantity + 1;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.add_circle_outline,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      // Update pantry with new quantities
                      _ingredients = _allAvailableIngredients
                          .where(
                            (ingredient) =>
                                (ingredientQuantities[ingredient.id] ?? 0) > 0,
                          )
                          .map(
                            (ingredient) => Ingredient(
                              id: ingredient.id,
                              name: ingredient.name,
                              unit: ingredient.unit,
                              quantity:
                                  ingredientQuantities[ingredient.id] ?? 0,
                              image: ingredient.image,
                            ),
                          )
                          .toList();
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FFF9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Image.asset('lib/assets/images/logo.png', height: 32),
            const Expanded(
              child: Text(
                'Your Pantry',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C2C2C),
                ),
              ),
            ),
          ],
        ),
        actions: const [
          Icon(
            Icons.account_circle_outlined,
            size: 36,
            color: Color(0xFF2C2C2C),
          ),
          SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Ingredients list
          Expanded(
            child: _ingredients.isEmpty
                ? const Center(
                    child: Text(
                      'No ingredients in your pantry yet.\nTap "Edit Ingredients" to add some!',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xFF6F6F6F)),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _ingredients.length,
                    itemBuilder: (context, index) {
                      final ingredient = _ingredients[index];
                      return Card(
                        color: const Color(0xFFFDFDFD),
                        elevation: 3,
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: ListTile(
                          leading: Image.asset(
                            ingredient.image,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(
                            ingredient.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF2C2C2C),
                            ),
                          ),
                          subtitle: Text(
                            '${ingredient.quantity.toInt()} ${ingredient.unit}',
                            style: const TextStyle(color: Color(0xFF6F6F6F)),
                          ),
                          trailing: const Icon(
                            Icons.chevron_right,
                            color: Color(0xFF6F6F6F),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    IngredientMatchPage(ingredient: ingredient),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),

          // Edit Ingredients Button at bottom
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: _showEditIngredientsDialog,
                icon: const Icon(Icons.edit, color: Colors.white),
                label: const Text(
                  'Edit Ingredients',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
