import 'package:flutter/material.dart';
import '../../models/recipe.dart';
import '../../models/user.dart';
import '../../data/dummy/dummy_recipe.dart';
import '../../ui/recipe/recipe_detail_page.dart';
import '../../services/auth_service.dart';
import '../../data/database/database_helper.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Recipe> _filteredRecipes = [];
  bool _hasSearched = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_searchRecipes);
  }

  void _searchRecipes() {
    final query = _searchController.text.toLowerCase().trim();

    setState(() {
      _hasSearched = query.isNotEmpty;
      _filteredRecipes = query.isEmpty
          ? []
          : dummyRecipes
                .where((recipe) => recipe.title.toLowerCase().contains(query))
                .toList();
    });
  }

  Future<User?> _getCurrentUser() async {
    try {
      final authService = AuthService.instance;
      final dbHelper = DatabaseHelper.instance;
      final userId = await authService.getCurrentUserId();
      if (userId != null) {
        return await dbHelper.getUserById(userId);
      }
    } catch (e) {
      print('Error getting current user: $e');
    }
    return null;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _popularRecipeCard(Recipe recipe) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetailPage(recipe: recipe),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFDFDFD),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Image.asset(
                recipe.image,
                height: 80,
                width: double.maxFinite,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Container(height: 80, color: const Color(0xFFEAEAEA)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Text(
                recipe.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C2C2C),
                ),
              ),
            ),
          ],
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
                'Mahop Flex',
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
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/settings');
            },
            child: const Icon(
              Icons.account_circle_outlined,
              size: 36,
              color: Color(0xFF2C2C2C),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF8FFF9), Color(0xFFEAF8F0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<User?>(
                future: _getCurrentUser(),
                builder: (context, snapshot) {
                  String greeting = 'Good morning!';
                  if (snapshot.hasData && snapshot.data != null) {
                    greeting = 'Good morning, ${snapshot.data!.username}!';
                  }
                  return Text(
                    greeting,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2ECC71),
                    ),
                  );
                },
              ),
              const SizedBox(height: 6),
              const Text(
                'Get ready to cook?',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C2C2C),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search recipes...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: const Color(0xFFFDFDFD),
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              if (!_hasSearched) ...[
                const Text(
                  'Popular Recipes',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C2C2C),
                  ),
                ),
                const SizedBox(height: 12),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 2,
                  childAspectRatio: 0.7,
                  children: dummyRecipes
                      .map((recipe) => _popularRecipeCard(recipe))
                      .toList(),
                ),
                const SizedBox(height: 24),
              ],
              if (_hasSearched)
                _filteredRecipes.isEmpty
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            'No recipes found',
                            style: TextStyle(color: Color(0xFF6F6F6F)),
                          ),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _filteredRecipes.length,
                        itemBuilder: (context, index) {
                          final recipe = _filteredRecipes[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      RecipeDetailPage(recipe: recipe),
                                ),
                              );
                            },
                            child: Card(
                              color: const Color(0xFFFDFDFD),
                              elevation: 3,
                              margin: const EdgeInsets.only(bottom: 10),
                              child: ListTile(
                                title: Text(
                                  recipe.title,
                                  style: const TextStyle(
                                    color: Color(0xFF2C2C2C),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Text(
                                  recipe.ingredients
                                      .map(
                                        (i) =>
                                            '${i.name} (${i.quantity} ${i.unit})',
                                      )
                                      .join(', '),
                                  style: const TextStyle(
                                    color: Color(0xFF6F6F6F),
                                  ),
                                ),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16,
                                  color: Color(0xFF6F6F6F),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
            ],
          ),
        ),
      ),
    );
  }
}
