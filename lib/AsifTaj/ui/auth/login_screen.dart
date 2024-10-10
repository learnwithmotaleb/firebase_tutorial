import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/AsifTaj/ui/auth/phone_screen.dart';
import 'package:firebase_tutorial/AsifTaj/ui/auth/signup_screen.dart';
import 'package:firebase_tutorial/AsifTaj/widgets/round_button.dart';
import 'package:flutter/material.dart';

import '../../Screen/home_screen.dart';
import '../../widgets/toash_message.dart';

class LoginScreenF extends StatefulWidget {
  const LoginScreenF({super.key});

  @override
  State<LoginScreenF> createState() => _LoginScreenFState();
}

class _LoginScreenFState extends State<LoginScreenF> {
  TextEditingController eamil = TextEditingController();
  TextEditingController password = TextEditingController();
  bool loading = false;

  final _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false; // State to toggle password visibility
  bool _isRememberMeChecked = false;

  FirebaseAuth _auth = FirebaseAuth.instance;

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    // Regular expression for email validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
// State for the checkbox

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("LOGIN"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: eamil,
                  validator: _validateEmail,
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                TextFormField(
                  obscureText: !_isPasswordVisible,
                  controller: password,
                  validator: _validatePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible =
                              !_isPasswordVisible; // Toggle password visibility
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
                          _isRememberMeChecked =
                              value!; // Update checkbox state
                        });
                      },
                    ),
                    Text('Remember Me'),
                  ],
                ),
                SizedBox(height: 20),

                // Container with Text Button
                // Container(
                //   width: double.infinity,
                //   child: ElevatedButton(
                //     onPressed: (){
                //       if (_formKey.currentState!.validate()) {
                //         print("Okk");
                //       }
                //     },
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: Colors.blue,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(20),
                //       ),
                //       padding: EdgeInsets.symmetric(vertical: 15),
                //     ),
                //     child: Text('Login',style: TextStyle(
                //         color: Colors.white
                //     ),),
                //   ),
                // ),
                RoundButton(
                  title: "Continue",
                  loading: loading,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        loading = true;
                      });
                      _auth
                          .signInWithEmailAndPassword(
                              email: eamil.text, password: password.text)
                          .then((value) {
                        Utilis.showSuccessToast(
                            "Thank you! \nLogin Successful!");
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreenF()),
                            (route) => false);
                        setState(() {
                          loading = false;
                        });
                      }).onError((error, stacktree) {
                        Utilis.showFailedToast(
                            "Sorry Login Failed. \nPlease try again!");
                        setState(() {
                          loading = false;
                        });
                      });
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have accout?"),
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignupScreenF()));
                      },
                      child: Text(
                        "Signup",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),

                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: SizedBox(
                        width: 30,
                        height: 30,
                        child: Image.asset("assets/icons/google.png"),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> PhoneScreenF()));
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        child: Image.asset("assets/icons/phone.png"),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
