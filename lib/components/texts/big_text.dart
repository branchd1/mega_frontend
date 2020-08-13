import 'package:flutter/material.dart';

class BigText extends StatelessWidget{
  final String text;

  BigText(this.text, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Text(
        text,
        textScaleFactor: 2.5,
        textAlign: TextAlign.left,
        style: TextStyle(
            fontWeight: FontWeight.bold
        ),
      ),
      alignment: Alignment.bottomLeft,
    );
  }
}