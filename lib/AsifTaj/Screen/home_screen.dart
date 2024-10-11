import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_tutorial/AsifTaj/Screen/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../ui/auth/login_screen.dart';
import '../widgets/round_button.dart';
import '../widgets/toash_message.dart';
import 'firestore/alll page /home_page_body.dart';
import 'firestore/alll page /job_page_body.dart';
import 'firestore/alll page /profile_page_body.dart';
import 'firestore/alll page /traning_page_body.dart';
import 'firestore/post_screen.dart';

class HomeScreenF extends StatefulWidget {
  const HomeScreenF({super.key});

  @override
  State<HomeScreenF> createState() => _HomeScreenFState();
}

class _HomeScreenFState extends State<HomeScreenF> {
  int _selectedIndex = 0;

  // List of widget pages
  final List<Widget> _pages = [
    HomeScreen(),
    JobScreen(),
    TrainingScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LWM"),
        centerTitle: false,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Job',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Training',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(
                        'assets/icons/logo.png'), // Replace with your image asset
                  ),
                  SizedBox(height: 10),
                  Text(
                    'LWM',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                // Add your App Rate functionality
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text('App Rate'),
              onTap: () {
                // Add your App Rate functionality
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.privacy_tip),
              title: Text('Privacy Policy'),
              onTap: () {
                // Add your Privacy Policy functionality
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                FirebaseAuth auth = FirebaseAuth.instance;
                auth.signOut().then((value) {
                  Utilis.showSuccessToast("Logout Successful!");
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreenF()),
                      (route) => false);
                }).onError((error, messer) {
                  Utilis.showSuccessToast("Some Error. Please Check!");
                });

                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Placeholder pages for each tab






