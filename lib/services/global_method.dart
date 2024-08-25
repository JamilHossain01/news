
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GlobalMethods{
  static String formattedDateText(String publishedAt){
    final parseData = DateTime.parse(publishedAt);
    String formattedDate = DateFormat("yyyy-mm-dd hh:mm:ss").format(parseData);
    DateTime publishedDate = DateFormat("yyyy-mm-dd hh:mm:ss").parse(formattedDate);
    return '${publishedDate.day}/${publishedDate.month}/${publishedDate.year}ON${publishedDate.hour}:${publishedDate.minute}:${publishedDate.second}';
  }
  static Future<void> errorDialog({required BuildContext context,required String errorMessage})async{
    await showDialog(context: context, builder:(context) {
      return AlertDialog(
        content: Text(errorMessage),
        title: const Row(
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
        }, child: const Text('ok'))
      ],

      ) ;
    },);

  }
}