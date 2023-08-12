import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../event/event_screen.dart';
import '../profile/profile_screen.dart';
// Import your MapScreen widget
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

  void _showModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Modal Dialog'),
          content: Container(
            height: 100,
            child: Column(
              children: [
                TextButton(
                  child: Text('Traffic'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the modal
                  },
                ),
                TextButton(
                  child: Text('Events'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the modal
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('close'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the modal
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        elevation: 1,
        animationDuration: const Duration(milliseconds: 1000),
        destinations: const <Widget>[
          NavigationDestination(
              icon:
                  Icon(Icons.remove_circle_outline_sharp, color: Colors.white),
              label: 'Events',
              selectedIcon:
                  Icon(Icons.nearby_error_sharp, color: Colors.white)),
          NavigationDestination(
            icon: Icon(Icons.explore),
            label: 'Explore',
            selectedIcon: Icon(Icons.explore_outlined),
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          NavigationDestination(
            icon: Icon(Icons.car_crash_outlined),
            label: 'Events',
          ),
          NavigationDestination(
            icon: Icon(Icons.phone),
            label: 'Call',
          ),
        ],
        onDestinationSelected: (int index) {
          if (index == 3) {
            _showModal(context);
          } else if (index == 4) {
            String phoneNumber = '55856615';
            launch("tel:$phoneNumber");
          } else {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          }
        },
        selectedIndex: currentPageIndex,
        backgroundColor: Color.fromARGB(255, 87, 115, 148),
        surfaceTintColor: Color.fromARGB(255, 150, 13, 13),
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
