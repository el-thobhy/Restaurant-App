import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/favorite_page.dart';
import 'package:restaurant_app/ui/settings_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../ui/main_page.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);
  static const routeName = '/bottom_nav';

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _indexBottomNav = 0;

  final List<Widget> pageOptions = [
    const MainPage(),
    const FavoritePage(),
    const SettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageOptions.elementAt(_indexBottomNav),
      backgroundColor: Colors.black12,
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: SalomonBottomBar(
          onTap: (index) {
            setState(() {
              _indexBottomNav = index;
            });
          },
          currentIndex: _indexBottomNav,
          items: [
            SalomonBottomBarItem(
              icon: const Icon(Icons.restaurant),
              title: const Text("Resto"),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.favorite),
              title: const Text("Favorite"),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.settings),
              title: const Text("Settings"),
            ),
          ],
          unselectedItemColor: const Color.fromARGB(255, 46, 46, 46),
          selectedItemColor: Colors.white,
        ),
      ),
    );
  }
}