
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/AsifTaj/Screen/home_screen.dart';
import 'package:firebase_tutorial/AsifTaj/ui/auth/login_screen.dart';
import 'package:firebase_tutorial/Screen/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashServices {



  void isLogin(BuildContext context){
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if(user != null){
      Timer(Duration(seconds: 3), () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> HomeScreenF()),(route)=>false));

    }else{
      Timer(Duration(seconds: 3), () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> LoginScreenF()),(route)=>false));

    }




  }


}
