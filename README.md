# MahopFlex

A Flutter-based recipe and pantry management app with offline authentication and recipe serving scaling features.

## Features

### 🔐 Offline Authentication System
- **User Registration**: Create accounts with email, username, and password
- **Secure Login**: SHA-256 password hashing for security
- **Session Persistence**: Stay logged in across app restarts using SharedPreferences
- **SQLite Database**: All data stored locally for complete offline functionality
- **No Password Recovery**: Important reminder shown during registration

### 🥘 Recipe Management
- **10 Built-in Recipes**: Includes Omelette, Scrambled Eggs, Fried Rice, Grilled Cheese, Spaghetti Carbonara, Tomato Pasta, Pancakes, Chicken Stir Fry, Vegetable Soup, and French Toast
- **Recipe Details**: Each recipe includes:
  - Base serving size (default: 2 people)
  - Cooking time in minutes
  - Difficulty level (Easy, Medium, Hard)
  - Calories per serving
  - Step-by-step instructions
  - Ingredient list with quantities

### 🍳 Smart Pantry System
- **User-Specific Pantry**: Each user maintains their own ingredient inventory
- **13 Ingredients**: Eggs, Milk, Butter, Flour, Sugar, Chicken, Tomato, Cream, Pasta, Carrot, Rice, Cheese, Bread
- **Real-Time Updates**: Add/remove ingredients with +/- buttons
- **Database Persistence**: All pantry changes saved to SQLite
- **Visual Indicators**: Green checkmarks for available ingredients, gray circles for unavailable

### 📊 Recipe Matching Algorithm
- **Intelligent Matching**: Recipes sorted by ingredient availability
- **Match Categories**:
  - 🟢 Perfect Match: 100% ingredients available
  - 🟡 Partial Match: 50-99% ingredients available
  - 🔴 Low Match: <50% ingredients available
- **Match Count Display**: Shows "X/Y ingredients" for each recipe

### ⚖️ Serving Size Scaling
- **Dynamic Scaling**: Adjust servings from 1 to 12 people
- **Smart Time Calculation**: Uses logarithmic scaling formula `baseTime × (1 + (ratio - 1) × 0.3)`
- **Ingredient Scaling**: Linear scaling of all ingredient quantities
- **Calorie Calculation**: Total calories automatically calculated for selected servings
- **Visual Interface**: Easy-to-use +/- controls with serving count display

### 🎨 User Interface
- **Material Design**: Clean, modern UI with green color scheme (#16C154)
- **Bottom Navigation**: Three main tabs - Home, Pantry, Settings
- **Welcome Screen**: Login and Register options for new users
- **Recipe Cards**: Rich recipe display with images, match percentage, and info badges
- **Responsive Layout**: Smooth scrolling and adaptive layouts

## Technical Architecture

### Database Schema
```sql
-- Users table
CREATE TABLE users (
  id TEXT PRIMARY KEY,
  email TEXT NOT NULL,
  username TEXT NOT NULL,
  password_hash TEXT NOT NULL,
  created_at INTEGER NOT NULL
)

-- User pantry table
CREATE TABLE user_pantry (
  id TEXT PRIMARY KEY,
  user_id TEXT NOT NULL,
  ingredient_name TEXT NOT NULL,
  quantity REAL NOT NULL,
  last_updated INTEGER,
  FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
)

-- Recipes table
CREATE TABLE recipes (
  id TEXT PRIMARY KEY,
  title TEXT NOT NULL,
  image TEXT NOT NULL,
  base_servings INTEGER NOT NULL,
  time_minutes INTEGER NOT NULL,
  difficulty TEXT NOT NULL,
  calories_per_serving INTEGER NOT NULL,
  instructions TEXT NOT NULL
)

-- Recipe ingredients table
CREATE TABLE recipe_ingredients (
  id TEXT PRIMARY KEY,
  recipe_id TEXT NOT NULL,
  ingredient_name TEXT NOT NULL,
  quantity REAL NOT NULL,
  unit TEXT NOT NULL,
  FOREIGN KEY (recipe_id) REFERENCES recipes (id) ON DELETE CASCADE
)
```

### Key Components

#### Services
- **AuthService** (`lib/services/auth_service.dart`): Handles user authentication, password hashing, and session management

#### Database
- **DatabaseHelper** (`lib/data/database/database_helper.dart`): SQLite database operations for users, pantry items, and recipes

#### Models
- **User**: id, username, email, passwordHash, createdAt
- **Recipe**: id, title, ingredients, image, baseServings, timeMinutes, difficulty, caloriesPerServing, instructions
- **Ingredient**: id, name, unit, quantity, image
- **UserPantryItem**: id, userId, ingredientName, quantity, lastUpdated

#### UI Pages
- **WelcomePage**: Landing page with Login/Register options
- **LoginPage**: User login form
- **RegisterPage**: User registration form with password confirmation
- **BottomNavTab**: Main navigation with Home, Pantry, Settings tabs
- **PantryPage**: User pantry management with +/- controls
- **RecipeListPage**: Recipe matching and sorting by availability
- **RecipeDetailPage**: Full recipe view with serving scaling
- **SettingsPage**: User profile and logout functionality

### Dependencies
```yaml
dependencies:
  sqflite: ^2.3.0          # SQLite database
  path: ^1.8.3             # Path manipulation
  shared_preferences: ^2.2.2  # Session storage
  crypto: ^3.0.3           # SHA-256 password hashing
```

## Security Features

- ✅ SHA-256 password hashing (never stores plain text passwords)
- ✅ Session management with SharedPreferences
- ✅ User isolation (each user has separate pantry data)
- ✅ Input validation (email format, password length)
- ✅ No forgot password feature (offline-first design)

## Getting Started

### Prerequisites
- Flutter SDK ^3.9.2
- Dart SDK

### Installation
1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to start the app

### First Time Use
1. Launch the app
2. Tap "Register" to create a new account
3. Enter username, email, and password (min 6 characters)
4. **Important**: Remember your password! Password recovery is not available in offline mode
5. After registration, you'll be automatically logged in

### Using the App
1. **Pantry Management**: Navigate to Pantry tab, use +/- buttons to add ingredients
2. **Find Recipes**: Tap "Find Recipes" button to see matched recipes
3. **View Recipe**: Tap on a recipe to see full details
4. **Scale Servings**: Use +/- buttons in recipe detail to adjust serving size
5. **Logout**: Go to Settings tab and tap Logout button

## Recipe Scaling Formula

### Ingredients
Linear scaling: `scaledQuantity = baseQuantity × (targetServings / baseServings)`

Example: 2 eggs for 2 servings → 4 eggs for 4 servings

### Cooking Time
Logarithmic scaling: `scaledTime = baseTime × (1 + (ratio - 1) × 0.3)`

Example: 30 minutes for 2 servings → 39 minutes for 4 servings (not 60!)

### Calories
Linear scaling: `totalCalories = caloriesPerServing × targetServings`

Example: 250 cal/serving × 4 servings = 1000 total calories

## Project Structure
```
lib/
├── data/
│   ├── database/
│   │   └── database_helper.dart
│   └── dummy/
│       ├── dummy_ingredient.dart
│       └── dummy_recipe.dart
├── models/
│   ├── ingredient.dart
│   ├── recipe.dart
│   ├── user.dart
│   └── user_pantry_item.dart
├── services/
│   └── auth_service.dart
├── ui/
│   ├── Login_Register_Page/
│   │   ├── login_Page.dart
│   │   └── register_Page.dart
│   ├── Welcome_Page/
│   │   └── welcome_Page.dart
│   ├── pantry/
│   │   └── pantry_page.dart
│   ├── recipe/
│   │   ├── recipe_detail_page.dart
│   │   └── recipe_list_page.dart
│   ├── settings/
│   │   └── settings_page.dart
│   └── widgets/
│       └── custom_button.dart
├── tab/
│   └── tab_page.dart
└── main.dart
```

## Testing Checklist
- ✅ User can register with email and password
- ✅ Password is hashed and stored securely
- ✅ User can login with correct credentials
- ✅ Login fails with incorrect credentials
- ✅ User stays logged in after app restart
- ✅ User can logout successfully
- ✅ Pantry quantities persist in database
- ✅ +/- buttons update pantry quantities
- ✅ Recipe ingredients scale correctly with servings
- ✅ Cooking time scales logarithmically
- ✅ Total calories calculate correctly
- ✅ Recipe matching works based on pantry items
- ✅ Each user has separate pantry data

## Known Limitations
- Password recovery not available (offline-first design)
- Limited to 13 predefined ingredients
- Maximum 12 servings per recipe
- No online sync capabilities

## Future Enhancements
- Custom recipe creation
- Shopping list generation
- Recipe favoriting
- Nutritional information breakdown
- Ingredient categories and filtering
- Recipe search functionality

## License
This project is a Flutter learning application.
