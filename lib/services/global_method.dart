
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GlobalMethods{
  static Future<void> errorDialog({required BuildContext context,required String errorMessage})async{
    await showDialog(context: context, builder:(context) {
      return AlertDialog(
        content: Text(errorMessage),
        title: Row(
          children: [
            Icon(Icons.dangerous,color: Colors.red,),
            SizedBox(width: 5,),
            Text('Error ocupide'),

          ],
        ),actions: [
        TextButton(onPressed: (){
          if(Navigator.canPop(context)){
            Navigator.pop(context);

          }
        }, child: Text('ok'))
      ],

      ) ;
    },);

  }
}