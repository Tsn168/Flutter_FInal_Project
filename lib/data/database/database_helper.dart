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
      version: 3,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

  Future<void> _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Add profile_image column if it doesn't exist
      try {
        await db.execute('ALTER TABLE users ADD COLUMN profile_image TEXT');
      } catch (e) {
        print('Migration: profile_image column already exists or error: $e');
      }
    }
    if (oldVersion < 3) {
      // Remove unused columns from recipes table
      try {
        // SQLite doesn't support DROP COLUMN directly, so we recreate the table
        await db.execute('''
          CREATE TABLE recipes_new (
            id TEXT PRIMARY KEY,
            title TEXT NOT NULL,
            image TEXT NOT NULL,
            base_servings INTEGER NOT NULL,
            time_minutes INTEGER NOT NULL,
            calories_per_serving INTEGER NOT NULL
          )
        ''');
        await db.execute('''
          INSERT INTO recipes_new (id, title, image, base_servings, time_minutes, calories_per_serving)
          SELECT id, title, image, base_servings, time_minutes, calories_per_serving FROM recipes
        ''');
        await db.execute('DROP TABLE recipes');
        await db.execute('ALTER TABLE recipes_new RENAME TO recipes');
      } catch (e) {
        print('Migration: Error updating recipes table: $e');
      }
      try {
        // Remove created_at column from users table
        await db.execute('''
          CREATE TABLE users_new (
            id TEXT PRIMARY KEY,
            email TEXT NOT NULL,
            username TEXT NOT NULL,
            password_hash TEXT NOT NULL,
            profile_image TEXT
          )
        ''');
        await db.execute('''
          INSERT INTO users_new (id, email, username, password_hash, profile_image)
          SELECT id, email, username, password_hash, profile_image FROM users
        ''');
        await db.execute('DROP TABLE users');
        await db.execute('ALTER TABLE users_new RENAME TO users');
      } catch (e) {
        print('Migration: Error updating users table: $e');
      }
    }
  }

  Future<void> _createDB(Database db, int version) async {
    const idType = 'TEXT PRIMARY KEY';
    const textType = 'TEXT NOT NULL';
    const intType = 'INTEGER NOT NULL';
    const realType = 'REAL NOT NULL';

    // Users table
    await db.execute('''
      CREATE TABLE users (
        id TEXT PRIMARY KEY,
        email TEXT NOT NULL,
        username TEXT NOT NULL,
        password_hash TEXT NOT NULL,
        profile_image TEXT
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
        calories_per_serving $intType
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
    final maps = await db.query('users', where: 'id = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<void> updateUser(User user) async {
    final db = await database;
    await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
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
    await db.delete('user_pantry', where: 'id = ?', whereArgs: [id]);
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
