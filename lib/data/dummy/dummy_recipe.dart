import '../../models/recipe.dart';
import 'dummy_ingredient.dart';

final List<Recipe> dummyRecipes = [
  Recipe(
    id: 'r1',
    title: 'Scrambled Eggs',
    ingredients: [eggs, milk, butter],

    image: 'lib/assets/images/scrambled.jpg',
  ),
  Recipe(
    id: 'r2',
    title: 'Pancakes',
    ingredients: [flour, eggs, milk, sugar, butter],

    image: 'lib/assets/images/pancake.png',
  ),
  Recipe(
    id: 'r3',
    title: 'Tomato Chicken',
    ingredients: [chicken, tomato, butter],

    image: 'lib/assets/images/potatochicken.png',
  ),
  Recipe(
    id: 'r4',
    title: 'Chicken Fried',
    ingredients: [chicken, butter, flour],
    image: 'lib/assets/images/image.png',
  ),
  Recipe(
    id: 'r5',
    title: 'Pasta Tomato',
    ingredients: [eggs, sugar, pasta, tomato],
    image: 'lib/assets/images/pastatomato.png',
  ),
  Recipe(
    id: 'r6',
    title: 'Basic Cake',
    ingredients: [cream, butter, flour],
    image: 'lib/assets/images/basiccake.png',
  ),
  Recipe(
    id: 'r7',
    title: 'Soup',
    ingredients: [chicken, carrot],
    image: 'lib/assets/images/soup.jpg',
  ),
  Recipe(
    id: 'r8',
    title: 'Chicken rolls',
    ingredients: [chicken, butter, flour],
    image: 'lib/assets/images/chickenrolls.png',
  ),
  Recipe(
    id: 'r9',
    title: 'Creamy chicken',
    ingredients: [chicken, butter, flour],
    image: 'lib/assets/images/creamychicken.png',
  ),
];
