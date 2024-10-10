import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/AsifTaj/widgets/round_button.dart';
import 'package:flutter/material.dart';

import '../../widgets/toash_message.dart';
import 'login_screen.dart';

class SignupScreenF extends StatefulWidget {
  const SignupScreenF({super.key});

  @override
  State<SignupScreenF> createState() => _SignupScreenFState();
}

class _SignupScreenFState extends State<SignupScreenF> {

  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController re_Password = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false; // State to toggle password visibility
  bool _isRe_PasswordVisible = false; // State to toggle password visibility

  bool loading = false;



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
  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your Name';
    }
    return null;
  }
  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your Phone';
    }
    // Regular expression for email validation
    final phoneRegex = RegExp(r'^\d{10}$'); // Adjust to match specific phone format if needed
    if (!phoneRegex.hasMatch(value)) {
      return 'Please enter a valid 10-digit phone number';
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
  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your re-password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }


  FirebaseAuth _auth = FirebaseAuth.instance;



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("SIGNUP"),
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
                  keyboardType: TextInputType.name,
                  controller: name,
                  validator: _validateName,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: phone,
                  validator: _validatePhone,
                  decoration: InputDecoration(
                    labelText: 'Phone',
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: email,
                  validator: _validateEmail,
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
                  validator: _validatePassword,
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
                SizedBox(height: 10),
                TextFormField(
                  obscureText: !_isRe_PasswordVisible,
                  controller: re_Password,
                  validator: _validateConfirmPassword,
                  decoration: InputDecoration(
                    labelText: 'Re-Password',
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isRe_PasswordVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isRe_PasswordVisible = !_isRe_PasswordVisible; // Toggle password visibility
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
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
                RoundButton(title: "Continue", loading: loading, onTap: () {
                  if (_formKey.currentState!.validate()) {
                   setState(() {
                     loading = true;
                   });
                    _auth.createUserWithEmailAndPassword(email: email.text, password: password.text).then((value){
                      Utilis.showSuccessToast("Congrgration!\nSignup Successful!");
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> LoginScreenF()),(route)=> false);
                      setState(() {
                        loading = false;
                      });
                    }).onError((error, stacktree){
                      Utilis.showFailedToast("Already Used email. \nPlease try again another email!");
                      setState(() {
                        loading = false;
                      });
                    });
                  }
                },),
                SizedBox(height: 20,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("have already accout?"),
                    SizedBox(width: 20,),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreenF()));
                      },
                      child: Text("Login",style: TextStyle(
                          fontWeight:FontWeight.bold
                      ),),

                    )
                  ],
                ),

                SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){

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
                      child: Image.asset("assets/icons/phone.png"),
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


