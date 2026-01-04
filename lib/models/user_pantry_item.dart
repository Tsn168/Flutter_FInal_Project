class UserPantryItem {
  final String id;
  final String userId;
  final String ingredientName;
  final double quantity;
  final DateTime? lastUpdated;

  UserPantryItem({
    required this.id,
    required this.userId,
    required this.ingredientName,
    required this.quantity,
    this.lastUpdated,
  });

  // Convert to Map for database INSERT
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'ingredient_name': ingredientName,
      'quantity': quantity,
      'last_updated': lastUpdated?.millisecondsSinceEpoch,
    };
  }

  // Create from Map (database SELECT)
  factory UserPantryItem.fromMap(Map<String, dynamic> map) {
    return UserPantryItem(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      ingredientName: map['ingredient_name'] as String,
      quantity: map['quantity'] as double,
      lastUpdated: map['last_updated'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['last_updated'] as int)
          : null,
    );
  }
}
