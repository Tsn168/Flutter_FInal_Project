import '../../models/recipe.dart';
import 'dummy_ingredient.dart';

final List<Recipe> dummyRecipes = [
  Recipe(
    id: 'r1',
    title: 'Omelette',
    ingredients: [eggs, milk, butter],
    image: 'lib/assets/images/omelet.png',
    baseServings: 2,
    timeMinutes: 15,
    difficulty: 'Easy',
    caloriesPerServing: 250,
    instructions: '''1. Beat eggs with milk in a bowl.
2. Heat butter in a non-stick pan over medium heat.
3. Pour egg mixture into the pan.
4. Cook for 2-3 minutes until bottom is set.
5. Fold omelette in half and serve hot.''',
  ),
  Recipe(
    id: 'r2',
    title: 'Scrambled Eggs',
    ingredients: [eggs, milk, butter],
    image: 'lib/assets/images/scrambled.jpg',
    baseServings: 2,
    timeMinutes: 10,
    difficulty: 'Easy',
    caloriesPerServing: 200,
    instructions: '''1. Beat eggs with milk in a bowl.
2. Heat butter in a pan over low heat.
3. Pour in egg mixture and stir gently.
4. Cook until eggs are softly set.
5. Season with salt and pepper, serve immediately.''',
  ),
  Recipe(
    id: 'r3',
    title: 'Fried Rice',
    ingredients: [rice, eggs, carrot, chicken],
    image: 'lib/assets/images/image.png',
    baseServings: 2,
    timeMinutes: 25,
    difficulty: 'Medium',
    caloriesPerServing: 350,
    instructions: '''1. Cook rice and let it cool completely.
2. Beat eggs and scramble them in a wok.
3. Add diced chicken and cook until done.
4. Add rice, carrots, and stir-fry on high heat.
5. Season with soy sauce and serve hot.''',
  ),
  Recipe(
    id: 'r4',
    title: 'Grilled Cheese',
    ingredients: [cheese, butter, bread],
    image: 'lib/assets/images/basiccake.png',
    baseServings: 2,
    timeMinutes: 10,
    difficulty: 'Easy',
    caloriesPerServing: 300,
    instructions: '''1. Butter one side of each bread slice.
2. Place cheese between bread slices, buttered side out.
3. Heat a pan over medium heat.
4. Grill sandwich until golden on both sides.
5. Cut in half and serve warm.''',
  ),
  Recipe(
    id: 'r5',
    title: 'Spaghetti Carbonara',
    ingredients: [pasta, eggs, cheese, butter],
    image: 'lib/assets/images/cabonara.png',
    baseServings: 2,
    timeMinutes: 30,
    difficulty: 'Medium',
    caloriesPerServing: 450,
    instructions: '''1. Cook spaghetti according to package directions.
2. Beat eggs with grated cheese in a bowl.
3. Drain pasta, reserving some pasta water.
4. Mix hot pasta with egg mixture off heat.
5. Add butter and pasta water to create creamy sauce.''',
  ),
  Recipe(
    id: 'r6',
    title: 'Tomato Pasta',
    ingredients: [pasta, tomato, butter, sugar],
    image: 'lib/assets/images/pastatomato.png',
    baseServings: 2,
    timeMinutes: 20,
    difficulty: 'Easy',
    caloriesPerServing: 320,
    instructions: '''1. Cook pasta in boiling salted water.
2. Heat butter in a pan and add diced tomatoes.
3. Add a pinch of sugar and cook for 10 minutes.
4. Drain pasta and toss with tomato sauce.
5. Serve hot with grated cheese if desired.''',
  ),
  Recipe(
    id: 'r7',
    title: 'Pancakes',
    ingredients: [flour, eggs, milk, sugar, butter],
    image: 'lib/assets/images/pancake.png',
    baseServings: 2,
    timeMinutes: 20,
    difficulty: 'Easy',
    caloriesPerServing: 280,
    instructions: '''1. Mix flour, eggs, milk, and sugar until smooth.
2. Heat butter in a non-stick pan.
3. Pour batter to form small circles.
4. Cook until bubbles form, then flip.
5. Stack pancakes and serve with syrup.''',
  ),
  Recipe(
    id: 'r8',
    title: 'Chicken Stir Fry',
    ingredients: [chicken, carrot, butter, flour],
    image: 'lib/assets/images/chickenrolls.png',
    baseServings: 2,
    timeMinutes: 30,
    difficulty: 'Medium',
    caloriesPerServing: 380,
    instructions: '''1. Cut chicken into bite-sized pieces.
2. Toss chicken with flour to coat lightly.
3. Heat butter in a wok over high heat.
4. Stir-fry chicken until golden, add carrots.
5. Cook until vegetables are tender-crisp.''',
  ),
  Recipe(
    id: 'r9',
    title: 'Vegetable Soup',
    ingredients: [carrot, tomato, chicken, butter],
    image: 'lib/assets/images/soup.jpg',
    baseServings: 2,
    timeMinutes: 35,
    difficulty: 'Easy',
    caloriesPerServing: 150,
    instructions: '''1. Dice all vegetables into small pieces.
2. Heat butter in a pot and sauté vegetables.
3. Add chicken pieces and cook until browned.
4. Add water and simmer for 20 minutes.
5. Season to taste and serve hot.''',
  ),
  Recipe(
    id: 'r10',
    title: 'French Toast',
    ingredients: [bread, eggs, milk, sugar, butter],
    image: 'lib/assets/images/toast.png',
    baseServings: 2,
    timeMinutes: 15,
    difficulty: 'Easy',
    caloriesPerServing: 260,
    instructions: '''1. Beat eggs with milk and sugar.
2. Dip bread slices in egg mixture.
3. Heat butter in a pan over medium heat.
4. Cook bread until golden on both sides.
5. Serve with maple syrup and fresh fruit.''',
  ),
];
