import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/database/database_helper.dart';
import '../models/user.dart';

class AuthService {
  static final AuthService instance = AuthService._init();
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  AuthService._init();

  // Hash password using SHA-256
  String hashPassword(String password) {
    var bytes = utf8.encode(password);
    var hash = sha256.convert(bytes);
    return hash.toString();
  }

  // Register new user
  Future<Map<String, dynamic>> register(
      String email, String username, String password) async {
    try {
      // Check if user already exists
      final existingUser = await _dbHelper.getUserByEmail(email);
      if (existingUser != null) {
        return {'success': false, 'message': 'Email already registered'};
      }

      // Hash password
      final passwordHash = hashPassword(password);

      // Create user
      final user = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        username: username,
        email: email,
        passwordHash: passwordHash,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );

      await _dbHelper.createUser(user);

      // Create session
      await _saveSession(user.id);

      return {'success': true, 'userId': user.id};
    } catch (e) {
      return {'success': false, 'message': 'Registration failed: $e'};
    }
  }

  // Login user
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      // Get user by email
      final user = await _dbHelper.getUserByEmail(email);
      if (user == null) {
        return {'success': false, 'message': 'Invalid email or password'};
      }

      // Compare password hashes
      final passwordHash = hashPassword(password);
      if (user.passwordHash != passwordHash) {
        return {'success': false, 'message': 'Invalid email or password'};
      }

      // Create session
      await _saveSession(user.id);

      return {'success': true, 'userId': user.id};
    } catch (e) {
      return {'success': false, 'message': 'Login failed: $e'};
    }
  }

  // Logout user
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove('currentUserId');
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  // Get current user ID
  Future<String?> getCurrentUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('currentUserId');
  }

  // Save session to SharedPreferences
  Future<void> _saveSession(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('currentUserId', userId);
  }
}
