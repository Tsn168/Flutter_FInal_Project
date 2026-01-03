class Ingredient {
  final String id;
  final String name; // e.g., "Eggs", "Flour"
  final String unit; // e.g., "pcs", "grams", "ml"
  final double quantity; // numeric quantity
  final String image;

  Ingredient({
    required this.id,
    required this.name,
    required this.unit,
    required this.quantity,
    required this.image,
  });
}
