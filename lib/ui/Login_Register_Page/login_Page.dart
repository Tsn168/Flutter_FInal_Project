import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, home: LoginPage()),
  );
}

// Stateful Widget for managing state
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
    // Navigate to registration screen
    print('Register clicked');
  }

  void _saveEmail(String? value) {
    _email = value;
  }

  void _savePassword(String? value) {
    _password = value;
  }

  @override
  Widget build(BuildContext context) {
    return LoginForm(
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
class LoginForm extends StatelessWidget {
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

  const LoginForm({
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
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 100),
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
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0, left: 30, right: 30),
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
                                "Welcome !",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "Sign in to continue",
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
                      const SizedBox(height: 40),
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
                      const SizedBox(height: 60),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1AE965),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 100,
                            vertical: 15,
                          ),
                          elevation: 8,
                          shadowColor: Colors.black.withOpacity(1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: onLoginPressed,
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: onForgotPasswordPressed,
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
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
                            "Don't have an account?",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          TextButton(
                            onPressed: onRegisterPressed,
                            child: const Text(
                              "Register",
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
        ],
      ),
    );
  }
}
