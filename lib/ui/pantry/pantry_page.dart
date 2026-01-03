import 'package:flutter/material.dart';
import '../../data/dummy/dummy_ingredient.dart'; // <-- import your ingredients
import '../../models/ingredient.dart';
import '../IngredientMatch/IngredientMatch.dart';

class PantryPage extends StatefulWidget {
  const PantryPage({super.key});

  @override
  State<PantryPage> createState() => _PantryPageState();
}

class _PantryPageState extends State<PantryPage> {
  late List<Ingredient> _ingredients;

  @override
  void initState() {
    super.initState();
    // Use all your predefined ingredients as default pantry
    _ingredients = [
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
      body: _ingredients.isEmpty
          ? const Center(
              child: Text(
                'No ingredients yet',
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
                      '${ingredient.quantity} ${ingredient.unit}',
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
    );
  }
}
