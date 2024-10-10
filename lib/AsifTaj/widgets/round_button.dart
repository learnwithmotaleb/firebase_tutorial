import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget{

  final title;
  final VoidCallback? onTap;
  final Color? color;
  final loading;

  const RoundButton({super.key, required this.title, required this.onTap, this.color = Colors.blue, this.loading = false});


  @override
  Widget build(BuildContext context) {


   return InkWell(
     onTap: onTap,
     child: Container(
       height: 50,
       decoration: BoxDecoration(
         color: color,
         borderRadius: BorderRadius.circular(10),
       ),
       child: Center(
         child: loading ? Padding(
           padding: const EdgeInsets.all(8.0),
           child: CircularProgressIndicator(color: Colors.white,),
         ): Text(title,style: TextStyle(
           fontSize: 18,
           color: Colors.white,
           fontWeight: FontWeight.bold,
         ),),
       ),


     ),
   );


  }


}