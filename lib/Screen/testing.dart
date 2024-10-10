import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'homepage.dart';

class TestApp extends StatefulWidget {
  @override
  _TestAppState createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  User? _user;

  // Initialize FirebaseAuth and GoogleSignIn
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _signInWithGoogle() async {
    try {
      // Trigger the Google Sign-In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // The user canceled the sign-in
        return;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the credential
      UserCredential userCredential = await _auth.signInWithCredential(credential);

      // if (userCredential.user != null) {
      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(builder: (context) => HomePage(user: userCredential.user!)),
      //   );
      // }

      // Retrieve the user information
      setState(() {
        _user = userCredential.user;
      });

      print("Signed in with Google successfully!");
    } catch (error) {
      print("Error signing in with Google: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Sign-Up"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display User Information
            if (_user != null) ...[
              CircleAvatar(
                backgroundImage: NetworkImage(_user!.photoURL ?? ''),
                radius: 40,
              ),
              SizedBox(height: 10),
              Text(
                'Name: ${_user!.displayName ?? ''}',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                'Email: ${_user!.email ?? ''}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await _auth.signOut();
                  await _googleSignIn.signOut();
                  setState(() {
                    _user = null;
                  });
                },
                child: Text("Sign Out"),
              ),
            ] else
            // Google Sign-In Button
              ElevatedButton(
                onPressed: _signInWithGoogle,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Google button color
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.account_circle),
                    SizedBox(width: 10),
                    Text("Sign in with Google"),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
