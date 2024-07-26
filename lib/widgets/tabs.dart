
import 'package:flutter/material.dart';

class TabsWidgets extends StatelessWidget {
  const TabsWidgets({super.key, required this.text, required this.color, required this.function, required this.fontSize});
  final String text;
  final Color color;
  final Function function;
  final double fontSize ;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        function();
        print('ok');
      },
      child: Container(decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),color: color,
      ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Text(text,style: TextStyle(fontSize: fontSize,fontWeight: FontWeight.w600),),
          )),
    ) ;
  }
}
