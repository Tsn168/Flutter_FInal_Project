import '../../models/recipe.dart';
import 'dummy_ingredient.dart';

final List<Recipe> dummyRecipes = [
  Recipe(
    id: 'r1',
    title: 'Scrambled Eggs',
    ingredients: [eggs, milk, butter],
    steps:
        '1. Beat the eggs with milk.\n2. Heat butter in pan.\n3. Cook eggs until fluffy.',
  ),
  Recipe(
    id: 'r2',
    title: 'Pancakes',
    ingredients: [flour, eggs, milk, sugar, butter],
    steps:
        '1. Mix flour, eggs, milk, sugar.\n2. Heat butter on pan.\n3. Cook batter until golden.',
  ),
  Recipe(
    id: 'r3',
    title: 'Tomato Chicken',
    ingredients: [chicken, tomato, butter],
    steps:
        '1. Cut chicken and tomato.\n2. Saute in butter.\n3. Cook until chicken is done.',
  ),
];
