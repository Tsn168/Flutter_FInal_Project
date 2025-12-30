import 'package:flutter/material.dart';
import '../../models/recipe.dart';
import '../../models/dummy_data_loader.dart';
import '../../data/dummy/dummy_recipe.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<Recipe> _filteredRecipes = [];
  bool _hasSearched = false; // ✅ ADDED (ONLY NEW STATE)

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_searchRecipes);
  }

  void _searchRecipes() {
    final query = _searchController.text.toLowerCase().trim();

    setState(() {
      _hasSearched = query.isNotEmpty;

      if (query.isEmpty) {
        _filteredRecipes = [];
      } else {
        _filteredRecipes = allRecipes.where((recipe) {
          return recipe.title.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Color(0xFFE8F5EE)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        title: Row(
          children: [
            InkWell(
              onTap: () {
                print('Logo pressed');
              },
              borderRadius: BorderRadius.circular(20),
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
                  fontFamily: 'Times New Roman',
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            padding: const EdgeInsets.only(right: 20),
            iconSize: 40,
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () {},
          ),
        ],
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xFF1AE965)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Good morning!',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 157, 155, 155),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Get Ready to cook?',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search recipes...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),

              // 📃 Recipe List (LOGIC FIX ONLY)
              Expanded(
                child: !_hasSearched
                    ? const SizedBox()
                    : _filteredRecipes.isEmpty
                    ? const Center(child: Text('No recipes found'))
                    : ListView.builder(
                        itemCount: _filteredRecipes.length,
                        itemBuilder: (context, index) {
                          final recipe = _filteredRecipes[index];
                          return ListTile(title: Text(recipe.title));
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
