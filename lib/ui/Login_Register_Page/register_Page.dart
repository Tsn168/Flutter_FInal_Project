import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: LoginPage()));
}

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

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
              onPressed: () {},
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
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
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
                      SizedBox(height: 30),
                      Row(
                        children: [
                          Icon(
                            Icons.email,
                            color: const Color.fromARGB(255, 107, 107, 107),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(hintText: "Email"),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 40),
                      Row(
                        children: [
                          Icon(
                            Icons.key,
                            color: const Color.fromARGB(255, 107, 107, 107),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              obscureText: _obscurePassword,
                              decoration: InputDecoration(
                                hintText: "Password",
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Color.fromARGB(255, 107, 107, 107),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 60),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF1AE965),
                          padding: EdgeInsets.symmetric(
                            horizontal: 100,
                            vertical: 15,
                          ),
                          elevation: 8,
                          shadowColor: Colors.black.withOpacity(1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(color: Colors.black, thickness: 1),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text("or"),
                          ),
                          Expanded(
                            child: Divider(color: Colors.black, thickness: 1),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Login with Google",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      TextButton(
                        onPressed: () {},
                        child: Image.asset(
                          '/Users/macbook/CADT/Flutter/Flutter_FInal_Project/lib/assets/images/search.png',
                          width: 20,
                          height: 20,
                        ),
                      ),

                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
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
