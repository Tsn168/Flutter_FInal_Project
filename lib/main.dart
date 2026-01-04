import 'package:flutter/material.dart';
import 'tab/tab_page.dart';
import 'ui/Welcome_Page/welcome_Page.dart';
import 'services/auth_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MahopFlex',
      home: const AuthCheck(),
    );
  }
}

// Check authentication status on app startup
class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final isLoggedIn = await AuthService.instance.isLoggedIn();
    
    if (!mounted) return;
    
    if (isLoggedIn) {
      // User is logged in, navigate to main app
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BottomNavTab()),
      );
    } else {
      // User is not logged in, navigate to welcome page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show loading indicator while checking auth status
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Color(0xFF16C154),
        ),
      ),
    );
  }
}
