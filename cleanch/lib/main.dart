import 'package:cleanch/screens/auth/login/login.dart';
import 'package:cleanch/screens/auth/signup/signup.dart';
import 'package:cleanch/screens/auth/welcome/welcome.dart';
import 'package:cleanch/screens/home/home.dart';
import 'package:cleanch/screens/updateProfile/updateProfile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/user_data_provider.dart';
import 'screens/auth/welcome/SplashScreen.dart';
import 'screens/event/event_screen.dart';
import 'screens/home/ScreenHomePage.dart';
import 'screens/profile/profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserDataProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My App',
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(),
          '/map': (context) => HomeScreen(),
          '/event': (context) => EventScreen(),
          '/profile': (context) => ProfileScreen(),
          '/updateProfile': (context) => UpdateProfileScreen(),
        },
      ),
    );
  }
}
