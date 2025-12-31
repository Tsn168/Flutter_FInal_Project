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

final allRecipes = [pancakeRecipe, scrambledEggsRecipe];
