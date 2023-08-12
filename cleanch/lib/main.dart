import 'package:cleanch/screens/home/home.dart';
import 'package:cleanch/screens/updateProfile/updateProfile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/user_data_provider.dart';
import 'screens/auth/welcome/SplashScreen.dart';
import 'screens/event/event_screen.dart';

import 'screens/profile/profile_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  print('User granted permission: ${settings.authorizationStatus}');
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    if (message.notification != null) {
      print('Notification Title: ${message.notification!.title}');
      print('Notification Body: ${message.notification!.body}');
    }
  });
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
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
          '/': (context) => SplashScreen(),
          '/map': (context) => HomeScreen(),
          '/event': (context) => EventScreen(),
          '/profile': (context) => ProfileScreen(),
          '/updateProfile': (context) => UpdateProfileScreen(),
        },
      ),
    );
  }
}
