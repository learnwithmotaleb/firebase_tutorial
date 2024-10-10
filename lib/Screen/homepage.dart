import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'auth/auth_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required User user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Appber"),
      ),

      body: Center(
        child: Text("Home Page"),
      ),

    );
  }
}
