import 'package:flutter/material.dart';
import '../../data/dummy/dummy_ingredient.dart';
import '../../models/ingredient.dart';
import '../../models/user_pantry_item.dart';
import '../../services/auth_service.dart';
import '../../data/database/database_helper.dart';
import '../recipe/recipe_list_page.dart';

class PantryPage extends StatefulWidget {
  const PantryPage({super.key});

  @override
  State<PantryPage> createState() => _PantryPageState();
}

class _PantryPageState extends State<PantryPage> {
  Map<String, double> _ingredientQuantities = {};
  bool _isLoading = true;
  String? _userId;

  @override
  void initState() {
    super.initState();
    _loadUserPantry();
  }

  Future<void> _loadUserPantry() async {
    _userId = await AuthService.instance.getCurrentUserId();
    
    if (_userId != null) {
      final pantryItems = await DatabaseHelper.instance.getUserPantryItems(_userId!);
      
      setState(() {
        // Initialize all ingredients with 0
        for (var ingredient in allIngredients) {
          _ingredientQuantities[ingredient.name] = 0;
        }
        
        // Update with saved quantities
        for (var item in pantryItems) {
          _ingredientQuantities[item.ingredientName] = item.quantity;
        }
        
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _updateQuantity(String ingredientName, double newQuantity) async {
    if (_userId == null) return;
    
    setState(() {
      _ingredientQuantities[ingredientName] = newQuantity;
    });
    
    // Save to database
    final item = UserPantryItem(
      id: '${_userId}_$ingredientName',
      userId: _userId!,
      ingredientName: ingredientName,
      quantity: newQuantity,
      lastUpdated: DateTime.now(),
    );
    
    await DatabaseHelper.instance.updateUserPantryItem(item);
  }

  void _incrementQuantity(String ingredientName) {
    final currentQuantity = _ingredientQuantities[ingredientName] ?? 0;
    _updateQuantity(ingredientName, currentQuantity + 1);
  }

  void _decrementQuantity(String ingredientName) {
    final currentQuantity = _ingredientQuantities[ingredientName] ?? 0;
    if (currentQuantity > 0) {
      _updateQuantity(ingredientName, currentQuantity - 1);
    }
  }

  void _navigateToRecipeList() {
    // Get list of available ingredients (quantity > 0)
    final availableIngredients = _ingredientQuantities.entries
        .where((entry) => entry.value > 0)
        .map((entry) => entry.key)
        .toList();
    
    if (availableIngredients.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please add some ingredients to your pantry first!'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecipeListPage(
          availableIngredients: availableIngredients,
        ),
      ),
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Ingredients list
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: allIngredients.length,
                    itemBuilder: (context, index) {
                      final ingredient = allIngredients[index];
                      final quantity = _ingredientQuantities[ingredient.name] ?? 0;
                      final hasIngredient = quantity > 0;
                      
                      return Card(
                        color: const Color(0xFFFDFDFD),
                        elevation: 3,
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              // Ingredient image
                              Image.asset(
                                ingredient.image,
                                width: 50,
                                height: 50,
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
                                        color: Color(0xFF2C2C2C),
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      ingredient.unit,
                                      style: const TextStyle(
                                        color: Color(0xFF6F6F6F),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              // Status icon
                              Icon(
                                hasIngredient ? Icons.check_circle : Icons.circle_outlined,
                                color: hasIngredient ? Colors.green : Colors.grey,
                              ),
                              const SizedBox(width: 8),
                              
                              // Quantity controls
                              Row(
                                children: [
                                  // Decrease button
                                  IconButton(
                                    onPressed: quantity > 0
                                        ? () => _decrementQuantity(ingredient.name)
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
                                      quantity.toInt().toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  
                                  // Increase button
                                  IconButton(
                                    onPressed: () => _incrementQuantity(ingredient.name),
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
                
                // Find Recipes Button at bottom
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: _navigateToRecipeList,
                      icon: const Icon(Icons.restaurant_menu, color: Colors.white),
                      label: const Text(
                        'Find Recipes',
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
