import 'package:flutter/material.dart';

class MainText extends StatelessWidget{
  final String text;

  const MainText(this.text, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textScaleFactor: 1.5,
    );
  }
}