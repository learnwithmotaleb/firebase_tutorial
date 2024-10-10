import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'AsifTaj/Screen/splash_screen.dart';
import 'Screen/homepage.dart';
import 'Screen/login_page.dart';
import 'Screen/signup_page.dart';
import 'Screen/testing.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'fireabase tutorial',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
        useMaterial3: false,
      ),
      home:  SplashScreen(),
    );
  }
}
