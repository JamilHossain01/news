
import 'package:flutter/material.dart';
import 'package:news71_app/services/utils.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key, required this.text, required this.imagePath});
final String text,imagePath;
  @override
  Widget build(BuildContext context) {
    Color color = Utils(context).getColor;
    return Column(mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Image.asset(imagePath),
      Text(text,style: TextStyle(color: color,fontSize: 30,fontWeight: FontWeight.w700),)

      ],


    );
  }
}
