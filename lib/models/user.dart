class User {
  final String id;
  final String username;
  final String email;
  final String passwordHash;
  final String? profileImage;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.passwordHash,
    this.profileImage,
  });

  // Convert User to Map for database INSERT
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'password_hash': passwordHash,
      'profile_image': profileImage,
    };
  }

  // Create User from Map (database SELECT)
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      email: map['email'] as String,
      username: map['username'] as String,
      passwordHash: map['password_hash'] as String,
      profileImage: map['profile_image'] as String?,
    );
  }
}
