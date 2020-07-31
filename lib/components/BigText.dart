import 'package:flutter/material.dart';

class BigText extends StatelessWidget{
  final String text;

  BigText({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Text(
        text,
        textScaleFactor: 3,
        textAlign: TextAlign.left,
        style: TextStyle(
            fontWeight: FontWeight.bold
        ),
      ),
      alignment: Alignment.bottomLeft,
    );
  }
}