import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      shadowColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: ListView(
        primary: false,
        children: <Widget>[
          const UserAccountsDrawerHeader(
            accountName: Text(
              'John Doe',
              style: TextStyle(color: Colors.black),
            ),
            accountEmail: Text(
              'johndoe@example.com',
              style: TextStyle(color: Colors.black),
            ),
            currentAccountPicture: CircleAvatar(
              foregroundImage: AssetImage('assets/images/avatar.jpg'),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
          Divider(
            color: Colors.transparent,
            height: 0,
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.priority_high_rounded),
                  title: Text('Property'),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
