import 'package:flutter/material.dart';
import 'package:globe_trek/core/constants/size_config.dart';
import 'package:globe_trek/screens/favourites_screen.dart';
import 'package:globe_trek/screens/home.dart';
import 'package:globe_trek/screens/profile_screen.dart';
import 'package:globe_trek/screens/search_screen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final List<Widget> _screens = [
    Home(),
    SearchScreen(),
    FavouritesScreen(),
    ProfileScreen(),
  ];

  int _selectedIndex = 0;

  void selectedScreen(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Explore'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        useLegacyColorScheme: true,
        backgroundColor: Colors.white,
        elevation: 2,
        type: BottomNavigationBarType.fixed,
        iconSize: 28,
        onTap: (value) {
            selectedScreen(value);
        },
      ),
    );
  }
}
