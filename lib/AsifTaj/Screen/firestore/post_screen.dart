import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../widgets/round_button.dart';
import '../../widgets/toash_message.dart';

class FireStoreScreen extends StatefulWidget {
  const FireStoreScreen({super.key});

  @override
  State<FireStoreScreen> createState() => _FireStoreScreenState();
}

class _FireStoreScreenState extends State<FireStoreScreen> {

  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  String? _validationTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your title';
    }

  }

  String? _validationDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your description';
    }

  }

  final databaseRef = FirebaseDatabase.instance.ref("User");




  void postData(){
    setState(() {
      loading = true;
    });
    if(_formKey.currentState!.validate()){


      print("Title: $title");
      print("Description: $description");

      var userID = DateTime.now().millisecondsSinceEpoch.toString();

      databaseRef.child(userID).set({
        "id": userID.toString(),
        "title": title.text,
        'description': description.text
      }).then((value){
        Utilis.showSuccessToast("Data Insert Success");
        Navigator.pop(context);
        setState(() {
          loading = false;
        });
      }).onError((error, e){
        Utilis.showFailedToast("Some Error, Please Check");
        setState(() {
          loading = false;
        });

      });


    }else{
      setState(() {
        loading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Center(
        child: Padding(padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 20,),

              TextFormField(
                controller: title,
                validator: _validationTitle,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Title',
                  prefixIcon: Icon(Iconsax.text),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: description,
                validator: _validationDescription,
                keyboardType: TextInputType.text,
                maxLength: 200,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Description',
                  hintText: "What is in your maind?",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              RoundButton(title: "Continue", loading: loading, onTap: (){
                postData();
              })

            ],
          ),
        ),),
      ),

    );
  }
}
