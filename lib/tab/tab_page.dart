import 'package:flutter/material.dart';
import '../ui/main/main_screen.dart';
import '../ui/pantry/pantry_page.dart';
import '../ui/settings/settings_page.dart';

class BottomNavTab extends StatefulWidget {
  const BottomNavTab({super.key});

  @override
  State<BottomNavTab> createState() => _BottomNavTabState();
}

class _BottomNavTabState extends State<BottomNavTab> {
  int _currentIndex = 0;

  // List of pages for each tab
  final List<Widget> _pages = [
    const MainScreen(), // Home
    const PantryPage(), // Pantry (+ button)
    const UserSetting(), // Settings
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 5, 223, 49),
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
        unselectedItemColor: const Color.fromARGB(255, 0, 0, 0),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'Pantry'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
