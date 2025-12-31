import 'package:flutter/material.dart';
import '../../models/recipe.dart';
import '../../data/dummy/dummy_recipe.dart';

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
          : allRecipes
                .where((recipe) => recipe.title.toLowerCase().contains(query))
                .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Popular Recipe Card Widget
  Widget _popularRecipeCard(Recipe recipe) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Container(
              height: 100,
              width: double.infinity,
              color: Colors.grey.shade300,
              child: const Icon(Icons.fastfood, size: 40),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              recipe.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  // Horizontal row of popular recipes
  Widget _popularRecipeRow({required bool reverse}) {
    return SizedBox(
      height: 170,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        reverse: reverse,
        itemCount: allRecipes.length,
        itemBuilder: (context, index) {
          return _popularRecipeCard(allRecipes[index]);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            InkWell(
              onTap: () {
                print('Logo pressed!');
              },
              child: Image.asset('lib/assets/images/logo.png', height: 32),
            ),
            const Expanded(
              child: Text(
                'Mahop Flex',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.account_circle_outlined,
              size: 36,
              color: Colors.black,
            ),
            onPressed: () {
              print('User icon pressed!');
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xFF1AE965)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Good morning!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Get ready to cook?',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 16),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search recipes...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 24),
              const Text(
                'Popular Recipes',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              // Layer 1 (normal)
              _popularRecipeRow(reverse: false),
              const SizedBox(height: 12),

              // Layer 2 (reversed)
              _popularRecipeRow(reverse: true),
              const SizedBox(height: 12),

              // Layer 3 (normal)
              _popularRecipeRow(reverse: false),
              const SizedBox(height: 12),

              // Search results
              Expanded(
                child: !_hasSearched
                    ? const SizedBox()
                    : _filteredRecipes.isEmpty
                    ? const Center(child: Text('No recipes found'))
                    : ListView.builder(
                        itemCount: _filteredRecipes.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(_filteredRecipes[index].title),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
