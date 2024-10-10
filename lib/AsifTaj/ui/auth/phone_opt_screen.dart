import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/AsifTaj/Screen/home_screen.dart';
import 'package:firebase_tutorial/AsifTaj/widgets/round_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

class PhoneOTPScreenF extends StatefulWidget {

  String verificationID;


   PhoneOTPScreenF({Key? key, required this.verificationID}) :super(key: key);


  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<PhoneOTPScreenF> with CodeAutoFill {
  final TextEditingController _otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    listenForCode(); // Start listening for the OTP code
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  bool loading = false;


  @override
  void codeUpdated() {
    // Auto-fill the OTP when SMS is received
    setState(() {
      widget.verificationID = code!;
    });
  }

  @override
  void dispose() {
    cancel(); // Stop listening when the screen is closed
    super.dispose();
  }

  void _submitOtp() async{
    setState(() {
      loading = true;
    });
    final crendital = PhoneAuthProvider.credential(
        verificationId: widget.verificationID,
        smsCode: _otpController.text.toString());
    try{
      await _auth.signInWithCredential(crendital);
      Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreenF()));
      setState(() {
        loading = false;
      });
    }catch(e){
      setState(() {
        loading = false;
      });
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('OTP Submitted: ${_otpController.text}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ENTER OTP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please check your phone number, \nwe are send otp.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 40),
            Padding(
              padding: EdgeInsets.all(30),
              child: PinFieldAutoFill(
                controller: _otpController,
                codeLength: 6, // Adjust OTP length if necessary
                decoration: UnderlineDecoration(
                  textStyle: TextStyle(fontSize: 20, color: Colors.black),
                  colorBuilder: FixedColorBuilder(Colors.grey),
                ),
                onCodeSubmitted: (code) => _submitOtp(),
              ),
            ),
            SizedBox(height: 40),
            RoundButton(title: "Continue", loading: loading, onTap:_submitOtp )
          ],
        ),
      ),
    );
  }
}