import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/Screen/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'auth/auth_services.dart';
import 'homepage.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController eamil = TextEditingController();
  TextEditingController password = TextEditingController();

  bool _isPasswordVisible = false; // State to toggle password visibility
  bool _isRememberMeChecked = false; // State for the checkbox
  final AuthService _authService = AuthService();

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

      if (userCredential.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage(user: userCredential.user!)),
        );
      }else{
        print("no");
      }

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
        title: Text('Login Page'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: eamil,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 10,),

              TextFormField(
                obscureText: !_isPasswordVisible,
                controller: password,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible; // Toggle password visibility
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Remember Me Checkbox
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    value: _isRememberMeChecked,
                    onChanged: (value) {
                      setState(() {
                        _isRememberMeChecked = value!; // Update checkbox state
                      });
                    },
                  ),
                  Text('Remember Me'),
                ],
              ),
              SizedBox(height: 20),

              // Container with Text Button
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle button click
                    print('Button Clicked');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: Text('Login',style: TextStyle(
                    color: Colors.white
                  ),),
                ),
              ),
              SizedBox(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have accout?"),
                  SizedBox(width: 20,),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUpScreen()));
                    },
                    child: Text("Signup",style: TextStyle(
                        fontWeight:FontWeight.bold
                    ),),

                  )
                ],
              ),

              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      _signInWithGoogle();

                    },
                    child:     SizedBox(
                      width: 30,
                      height: 30,
                      child: Image.asset("assets/icons/google.png"),
                   ),

                  ),
                  SizedBox(width: 20,),
                  Container(
                    width: 30,
                    height: 30,
                    child: Image.asset("assets/icons/facebook.png"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
