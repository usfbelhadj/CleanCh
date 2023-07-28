import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../event/event_screen.dart';
import '../profile/profile_screen.dart';
import 'ScreenHomePage.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // NavigationBar Example
      bottomNavigationBar: NavigationBar(
        elevation: 1,
        animationDuration: const Duration(milliseconds: 1000),
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.nearby_error),
            label: 'Events',
          ),
          NavigationDestination(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.lime,
        height: 60,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      ),
      body: <Widget>[
        EventScreen(),
        MapScreen(),
        ProfileScreen(),
      ][currentPageIndex],
    );
  }
}
