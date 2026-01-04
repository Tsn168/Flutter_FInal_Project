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

  // Convert to Map for database INSERT
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'unit': unit,
      'quantity': quantity,
      'image': image,
    };
  }

  // Create from Map (database SELECT)
  factory Ingredient.fromMap(Map<String, dynamic> map) {
    return Ingredient(
      id: map['id'] as String,
      name: map['name'] as String,
      unit: map['unit'] as String,
      quantity: (map['quantity'] as num).toDouble(),
      image: map['image'] as String,
    );
  }
}
