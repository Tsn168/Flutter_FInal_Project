import '../../models/ingredient.dart';

final Ingredient eggs = Ingredient(
  id: 'i1',
  name: 'Eggs',
  unit: 'pcs',
  quantity: 2,
  image: 'lib/assets/images/egg.png',
);

final Ingredient milk = Ingredient(
  id: 'i2',
  name: 'Milk',
  unit: 'ml',
  quantity: 100,
  image: 'lib/assets/images/milk.png',
);

final Ingredient butter = Ingredient(
  id: 'i3',
  name: 'Butter',
  unit: 'grams',
  quantity: 20,
  image: 'lib/assets/images/butter.png',
);

final Ingredient flour = Ingredient(
  id: 'i4',
  name: 'Flour',
  unit: 'grams',
  quantity: 100,
  image: 'lib/assets/images/flour.png',
);

final Ingredient sugar = Ingredient(
  id: 'i5',
  name: 'Sugar',
  unit: 'grams',
  quantity: 20,
  image: 'lib/assets/images/sugar.png',
);

final Ingredient chicken = Ingredient(
  id: 'i6',
  name: 'Chicken',
  unit: 'grams',
  quantity: 200,
  image: 'lib/assets/images/chicken.png',
);

final Ingredient tomato = Ingredient(
  id: 'i7',
  name: 'Tomato',
  unit: 'pcs',
  quantity: 2,
  image: 'lib/assets/images/tomato.png',
);

final Ingredient cream = Ingredient(
  id: 'i8',
  name: 'Cream',
  unit: 'ml',
  quantity: 50,
  image: 'lib/assets/images/cream.png',
);

final Ingredient pasta = Ingredient(
  id: 'i9',
  name: 'Pasta',
  unit: 'grams',
  quantity: 200,
  image: 'lib/assets/images/pasta.jpg',
);

final Ingredient carrot = Ingredient(
  id: 'i10',
  name: 'Carrot',
  unit: 'pcs',
  quantity: 2,
  image: 'lib/assets/images/carrot.png',
);

final Ingredient rice = Ingredient(
  id: 'i11',
  name: 'Rice',
  unit: 'grams',
  quantity: 200,
  image: 'lib/assets/images/flour.png',
);

final Ingredient cheese = Ingredient(
  id: 'i12',
  name: 'Cheese',
  unit: 'grams',
  quantity: 100,
  image: 'lib/assets/images/cream.png',
);

final Ingredient bread = Ingredient(
  id: 'i13',
  name: 'Bread',
  unit: 'slices',
  quantity: 4,
  image: 'lib/assets/images/flour.png',
);

// List of all available ingredients for the pantry
final List<Ingredient> allIngredients = [
  eggs,
  milk,
  butter,
  flour,
  sugar,
  chicken,
  tomato,
  cream,
  pasta,
  carrot,
  rice,
  cheese,
  bread,
];
