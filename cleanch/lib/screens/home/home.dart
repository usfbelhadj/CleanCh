import 'package:flutter/material.dart';
import '../event/event_screen.dart';
import '../profile/profile_screen.dart';
import 'ScreenHomePage.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  int currentPageIndex = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentPageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onPageChanged(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

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
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        },
        selectedIndex: currentPageIndex,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.lime,
        height: 60,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: <Widget>[
          EventScreen(),
          MapScreen(),
          ProfileScreen(),
        ],
      ),
    );
  }
}
