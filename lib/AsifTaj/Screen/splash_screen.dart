import 'package:firebase_tutorial/AsifTaj/firebase_services/splash_services.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SplashServices splashServices = SplashServices();

  TextEditingController eamil = TextEditingController();
  TextEditingController password = TextEditingController();

  bool _isPasswordVisible = false; // State to toggle password visibility
  bool _isRememberMeChecked = false; // State for the checkbox


  @override
  void initState() {
    super.initState();
    splashServices.isLogin(context);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage( "assets/icons/logo.png",),
            ),
            SizedBox(height: 20,),
            Text("LWM",style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              fontStyle: FontStyle.italic
            ),)
          ],
        ),
      ),
    );
  }
}
