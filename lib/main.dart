// import 'package:flutter/material.dart';
// import 'ui/main/main_screen.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: MainScreen(), // currently Main Page
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'ui/pantry/pantry_page.dart'; // make sure this path is correct

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'MahopFlex',
//       home: PantryPage(), // start app on PantryPage
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'tab/tab_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavTab(), // Start with the 3-tab page
    );
  }
}
