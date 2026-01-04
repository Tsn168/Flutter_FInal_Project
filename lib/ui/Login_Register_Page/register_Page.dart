import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import 'login_Page.dart';
import '../../services/auth_service.dart';
import '../../tab/tab_page.dart';

void main() {
  runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, home: RegisterPage()),
  );
}

// Stateful Widget for managing state
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;
  String? _username;
  String? _email;
  String? _password;
  String? _confirmPassword;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _obscureConfirmPassword = !_obscureConfirmPassword;
    });
  }

  void _handleBack() {
    Navigator.maybePop(context);
  }

  Future<void> _handleRegister() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      
      // Additional validation
      if (_password != _confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Passwords do not match'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      
      setState(() {
        _isLoading = true;
      });
      
      // Call AuthService to register
      final result = await AuthService.instance.register(
        _email!,
        _username!,
        _password!,
      );
      
      setState(() {
        _isLoading = false;
      });
      
      if (!mounted) return;
      
      if (result['success']) {
        // Navigate to BottomNavTab on success
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const BottomNavTab()),
          (route) => false,
        );
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message'] ?? 'Registration failed'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _handleLogin() {
    // Navigate to login screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  void _saveUsername(String? value) {
    _username = value;
  }

  void _saveEmail(String? value) {
    _email = value;
  }

  void _savePassword(String? value) {
    _password = value;
  }

  void _saveConfirmPassword(String? value) {
    _confirmPassword = value;
  }

  @override
  Widget build(BuildContext context) {
    return RegisterForm(
      formKey: _formKey,
      obscurePassword: _obscurePassword,
      obscureConfirmPassword: _obscureConfirmPassword,
      isLoading: _isLoading,
      onTogglePasswordVisibility: _togglePasswordVisibility,
      onToggleConfirmPasswordVisibility: _toggleConfirmPasswordVisibility,
      onBackPressed: _handleBack,
      onRegisterPressed: _handleRegister,
      onLoginPressed: _handleLogin,
      onUsernameSaved: _saveUsername,
      onEmailSaved: _saveEmail,
      onPasswordSaved: _savePassword,
      onConfirmPasswordSaved: _saveConfirmPassword,
    );
  }
}

// Stateless Widget for UI
class RegisterForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final bool isLoading;
  final VoidCallback onTogglePasswordVisibility;
  final VoidCallback onToggleConfirmPasswordVisibility;
  final VoidCallback onBackPressed;
  final VoidCallback onLoginPressed;
  final VoidCallback onRegisterPressed;
  final ValueChanged<String?>? onUsernameSaved;
  final ValueChanged<String?>? onEmailSaved;
  final ValueChanged<String?>? onPasswordSaved;
  final ValueChanged<String?>? onConfirmPasswordSaved;

  const RegisterForm({
    Key? key,
    required this.formKey,
    required this.obscurePassword,
    required this.obscureConfirmPassword,
    required this.isLoading,
    required this.onTogglePasswordVisibility,
    required this.onToggleConfirmPasswordVisibility,
    required this.onBackPressed,
    required this.onLoginPressed,
    required this.onRegisterPressed,
    this.onUsernameSaved,
    this.onEmailSaved,
    this.onPasswordSaved,
    this.onConfirmPasswordSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Top-left back button
          Positioned(
            top: 50,
            left: 16,
            child: TextButton(
              onPressed: onBackPressed,
              style: TextButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(10),
              ),
              child: const Icon(
                Icons.arrow_back,
                size: 36,
                color: Colors.black,
              ),
            ),
          ),
          // Main rounded-top container with gradient and register content
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF1AE965),
                    Color.fromARGB(255, 176, 255, 199),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: [0.7, 1.0],
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(60),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 40.0,
                    left: 30,
                    right: 30,
                    bottom: 30,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Hi !",
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "Create a new account",
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: const Color.fromARGB(
                                      255,
                                      105,
                                      105,
                                      105,
                                    ),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Warning banner
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade100,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.orange),
                          ),
                          child: Row(
                            children: const [
                              Icon(Icons.warning, color: Colors.orange),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Remember your password! Offline apps cannot recover passwords.',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Icon(
                              Icons.person,
                              color: Color.fromARGB(255, 107, 107, 107),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: "Username",
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your username';
                                  }
                                  return null;
                                },
                                onSaved: onUsernameSaved,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Icon(
                              Icons.email,
                              color: Color.fromARGB(255, 107, 107, 107),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: "Email",
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  if (!value.contains('@')) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                                onSaved: onEmailSaved,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Icon(
                              Icons.key,
                              color: Color.fromARGB(255, 107, 107, 107),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextFormField(
                                obscureText: obscurePassword,
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      obscurePassword
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: const Color.fromARGB(
                                        255,
                                        107,
                                        107,
                                        107,
                                      ),
                                    ),
                                    onPressed: onTogglePasswordVisibility,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  if (value.length < 6) {
                                    return 'Password must be at least 6 characters';
                                  }
                                  return null;
                                },
                                onSaved: onPasswordSaved,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Icon(
                              Icons.key,
                              color: Color.fromARGB(255, 107, 107, 107),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextFormField(
                                obscureText: obscureConfirmPassword,
                                decoration: InputDecoration(
                                  hintText: "Confirm Password",
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      obscureConfirmPassword
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: const Color.fromARGB(
                                        255,
                                        107,
                                        107,
                                        107,
                                      ),
                                    ),
                                    onPressed: onToggleConfirmPasswordVisibility,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please confirm your password';
                                  }
                                  return null;
                                },
                                onSaved: onConfirmPasswordSaved,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : CustomButton.text(
                                text: "Register",
                                onPressed: onRegisterPressed,
                                backgroundColor: const Color(0xFF1AE965),
                                textColor: Colors.white,
                                width: 250,
                                height: 60,
                                borderRadius: 20,
                                elevation: 8,
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Bottom account text
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account?",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                TextButton(
                  onPressed: onLoginPressed,
                  child: const Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
