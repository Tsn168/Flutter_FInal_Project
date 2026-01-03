import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import 'login_Page.dart';

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
  String? _email;
  String? _password;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _handleBack() {
    Navigator.maybePop(context);
  }

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      // Handle login logic here
      print('Email: $_email, Password: $_password');
      // You can add authentication logic here
    }
  }

  void _handleForgotPassword() {
    // Navigate to forgot password screen
    print('Forgot password clicked');
  }

  void _handleGoogleLogin() {
    // Handle Google login logic
    print('Google login clicked');
  }

  void _handleRegister() {
    // Navigate to login screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  void _saveEmail(String? value) {
    _email = value;
  }

  void _savePassword(String? value) {
    _password = value;
  }

  @override
  Widget build(BuildContext context) {
    return RegisterForm(
      formKey: _formKey,
      obscurePassword: _obscurePassword,
      onTogglePasswordVisibility: _togglePasswordVisibility,
      onBackPressed: _handleBack,
      onLoginPressed: _handleLogin,
      onForgotPasswordPressed: _handleForgotPassword,
      onGoogleLoginPressed: _handleGoogleLogin,
      onRegisterPressed: _handleRegister,
      onEmailSaved: _saveEmail,
      onPasswordSaved: _savePassword,
    );
  }
}

// Stateless Widget for UI
class RegisterForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final bool obscurePassword;
  final VoidCallback onTogglePasswordVisibility;
  final VoidCallback onBackPressed;
  final VoidCallback onLoginPressed;
  final VoidCallback onForgotPasswordPressed;
  final VoidCallback onGoogleLoginPressed;
  final VoidCallback onRegisterPressed;
  final ValueChanged<String?>? onEmailSaved;
  final ValueChanged<String?>? onPasswordSaved;

  const RegisterForm({
    Key? key,
    required this.formKey,
    required this.obscurePassword,
    required this.onTogglePasswordVisibility,
    required this.onBackPressed,
    required this.onLoginPressed,
    required this.onForgotPasswordPressed,
    required this.onGoogleLoginPressed,
    required this.onRegisterPressed,
    this.onEmailSaved,
    this.onPasswordSaved,
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
          // Main rounded-top container with gradient and login content
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
                        const SizedBox(height: 30),
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
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
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
                                  if (!RegExp(
                                    r'^[^@]+@[^@]+\.[^@]+',
                                  ).hasMatch(value)) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                                onSaved: onEmailSaved,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
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
                        const SizedBox(height: 40),
                        CustomButton.text(
                          text: "Register",
                          onPressed: onLoginPressed,
                          backgroundColor: const Color(0xFF1AE965),
                          textColor: Colors.white,
                          width: 250,
                          height: 60,
                          borderRadius: 20,
                          elevation: 8,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(color: Colors.black, thickness: 1),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text("or"),
                            ),
                            Expanded(
                              child: Divider(color: Colors.black, thickness: 1),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Login with Google",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: onGoogleLoginPressed,
                          child: Image.asset(
                            '/Users/macbook/CADT/Flutter/Flutter_FInal_Project/lib/assets/images/search.png',
                            width: 20,
                            height: 20,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account?",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            TextButton(
                              onPressed: onRegisterPressed,
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
