import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/AsifTaj/ui/auth/phone_opt_screen.dart';
import 'package:flutter/material.dart';
import '../../Screen/firestore/alll page /home_page_body.dart';
import '../../Screen/home_screen.dart';
import '../../widgets/round_button.dart';
import '../../widgets/toash_message.dart';

class PhoneScreenF extends StatefulWidget {
  const PhoneScreenF({super.key});

  @override
  State<PhoneScreenF> createState() => _PhoneScreenFState();
}

class _PhoneScreenFState extends State<PhoneScreenF> {
  TextEditingController phone = TextEditingController();
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth _auth = FirebaseAuth.instance;

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your Phone';
    }
    final phoneRegex = RegExp(r'^\+880\d{10}$'); // Example: +880 followed by 10 digits
    if (!phoneRegex.hasMatch(value)) {
      return 'Please enter a valid phone number (e.g., +8801234567890)';
    }
    return null;
  }

  @override
  void dispose() {
    phone.dispose();
    super.dispose();
  }

  Future<void> _verifyPhone() async {
    setState(() {
      loading = true;
    });

    await _auth.verifyPhoneNumber(
      phoneNumber: phone.text.trim(),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        Utilis.showSuccessToast("Verification successful!");
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
              (route) => false,
        );
      },
      verificationFailed: (FirebaseAuthException e) {
        Utilis.showFailedToast(e.message ?? "Verification failed. Please try again.");
        setState(() {
          loading = false;
        });
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          loading = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PhoneOTPScreenF(verificationID: verificationId),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        Utilis.showSuccessToast("Code retrieval timed out. Please try again.");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("PHONE"),
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
                  keyboardType: TextInputType.phone,
                  controller: phone,
                  validator: _validatePhone,
                  decoration: InputDecoration(
                    labelText: 'Phone',
                    hintText: "+880",
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                RoundButton(
                  title: "Continue",
                  loading: loading,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _verifyPhone();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
