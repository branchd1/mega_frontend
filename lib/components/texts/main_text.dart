import 'package:flutter/material.dart';

class MainText extends StatelessWidget{
  final String text;

  final bool textCenter;

  const MainText(this.text, {Key key, this.textCenter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textScaleFactor: 1.5,
      style: TextStyle(
        fontWeight: FontWeight.bold
      ),
      textAlign: textCenter!=null  && textCenter ? TextAlign.center : TextAlign.left,
    );
  }
}