import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../models/user.dart';
import '../../models/user_pantry_item.dart';
import '../../models/recipe.dart';
import '../../models/ingredient.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('mahopflex.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    const idType = 'TEXT PRIMARY KEY';
    const textType = 'TEXT NOT NULL';
    const intType = 'INTEGER NOT NULL';
    const realType = 'REAL NOT NULL';

    // Users table
    await db.execute('''
      CREATE TABLE users (
        id $idType,
        email $textType,
        username $textType,
        password_hash $textType,
        created_at $intType
      )
    ''');

    // User pantry table
    await db.execute('''
      CREATE TABLE user_pantry (
        id $idType,
        user_id $textType,
        ingredient_name $textType,
        quantity $realType,
        last_updated INTEGER,
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
      )
    ''');

    // Recipes table
    await db.execute('''
      CREATE TABLE recipes (
        id $idType,
        title $textType,
        image $textType,
        base_servings $intType,
        time_minutes $intType,
        difficulty $textType,
        calories_per_serving $intType,
        instructions $textType
      )
    ''');

    // Recipe ingredients table
    await db.execute('''
      CREATE TABLE recipe_ingredients (
        id $idType,
        recipe_id $textType,
        ingredient_name $textType,
        quantity $realType,
        unit $textType,
        FOREIGN KEY (recipe_id) REFERENCES recipes (id) ON DELETE CASCADE
      )
    ''');
  }

  // ===== USER OPERATIONS =====
  Future<User> createUser(User user) async {
    final db = await database;
    await db.insert('users', user.toMap());
    return user;
  }

  Future<User?> getUserByEmail(String email) async {
    final db = await database;
    final maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<User?> getUserById(String id) async {
    final db = await database;
    final maps = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  // ===== USER PANTRY OPERATIONS =====
  Future<void> updateUserPantryItem(UserPantryItem item) async {
    final db = await database;
    await db.insert(
      'user_pantry',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<UserPantryItem>> getUserPantryItems(String userId) async {
    final db = await database;
    final maps = await db.query(
      'user_pantry',
      where: 'user_id = ?',
      whereArgs: [userId],
    );

    return maps.map((map) => UserPantryItem.fromMap(map)).toList();
  }

  Future<void> deleteUserPantryItem(String id) async {
    final db = await database;
    await db.delete(
      'user_pantry',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // ===== RECIPE OPERATIONS =====
  Future<void> createRecipe(Recipe recipe) async {
    final db = await database;
    
    // Insert recipe
    await db.insert('recipes', recipe.toMap());
    
    // Insert recipe ingredients
    for (var ingredient in recipe.ingredients) {
      await db.insert('recipe_ingredients', {
        'id': '${recipe.id}_${ingredient.id}',
        'recipe_id': recipe.id,
        'ingredient_name': ingredient.name,
        'quantity': ingredient.quantity,
        'unit': ingredient.unit,
      });
    }
  }

  Future<List<Recipe>> getAllRecipes() async {
    final db = await database;
    final recipeMaps = await db.query('recipes');
    
    List<Recipe> recipes = [];
    for (var recipeMap in recipeMaps) {
      // Get ingredients for this recipe
      final ingredientMaps = await db.query(
        'recipe_ingredients',
        where: 'recipe_id = ?',
        whereArgs: [recipeMap['id']],
      );
      
      List<Ingredient> ingredients = ingredientMaps.map((map) {
        return Ingredient(
          id: map['id'] as String,
          name: map['ingredient_name'] as String,
          unit: map['unit'] as String,
          quantity: map['quantity'] as double,
          image: '', // Will be set from dummy data
        );
      }).toList();
      
      recipes.add(Recipe.fromMap(recipeMap, ingredients));
    }
    
    return recipes;
  }

  Future<Recipe?> getRecipeById(String id) async {
    final db = await database;
    final recipeMaps = await db.query(
      'recipes',
      where: 'id = ?',
      whereArgs: [id],
    );
    
    if (recipeMaps.isEmpty) return null;
    
    final recipeMap = recipeMaps.first;
    final ingredientMaps = await db.query(
      'recipe_ingredients',
      where: 'recipe_id = ?',
      whereArgs: [id],
    );
    
    List<Ingredient> ingredients = ingredientMaps.map((map) {
      return Ingredient(
        id: map['id'] as String,
        name: map['ingredient_name'] as String,
        unit: map['unit'] as String,
        quantity: map['quantity'] as double,
        image: '',
      );
    }).toList();
    
    return Recipe.fromMap(recipeMap, ingredients);
  }

  Future<void> close() async {
    final db = await database;
    db.close();
  }
}
