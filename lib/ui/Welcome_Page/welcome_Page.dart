import 'package:flutter/material.dart';
import '../Login_Register_Page/login_Page.dart';
import '../Login_Register_Page/register_Page.dart';
import '../widgets/custom_button.dart';


void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: WelcomePage()));
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1AE965), Colors.white],
            begin: Alignment.center,
            end: Alignment.bottomCenter,
            stops: [0.0, 1],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(100.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('lib/assets/images/logo.png', height: 100),
              SizedBox(height: 20),
              Text(
                "Mahop Flex",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 100),
              Text(
                "Welcome !",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Best place to help with organize your pantry and cook recipes",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              CustomButton.text(
                text: "Login",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                backgroundColor: Color.fromARGB(255, 22, 193, 84),
                textColor: Colors.white,
                width: 500,
                height: 60,
                fontSize: 30,
                borderRadius: 20,
              ),
              SizedBox(height: 10),
              CustomButton.text(
                text: "Register",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterPage()),
                  );
                },
                backgroundColor: Colors.white,
                textColor: Colors.black,
                width: 500,
                height: 60,
                fontSize: 30,
                borderRadius: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
