import '../../models/recipe.dart';
import 'dummy_ingredient.dart';

final pancakeRecipe = Recipe(
  id: 'r1',
  title: 'Pancakes',
  ingredients: [flour, eggs, milk, sugar],
);

final scrambledEggsRecipe = Recipe(
  id: 'r2',
  title: 'Scrambled Eggs',
  ingredients: [eggs, milk, butter],
);
final curryRecipe = Recipe(
  id: 'r3',
  title: 'Curry',
  ingredients: [chicken, curry_powder, coconut_milk, vegetables],
);
final allRecipes = [pancakeRecipe, scrambledEggsRecipe, curryRecipe];
