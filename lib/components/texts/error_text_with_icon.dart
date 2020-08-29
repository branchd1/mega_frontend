import 'package:flutter/material.dart';

class ErrorTextWithIcon extends StatelessWidget{
  final String text;
  final String subtext;

  const ErrorTextWithIcon({Key key, @required this.text, this.subtext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Icon(
          Icons.close,
          size: 100,
          color: Colors.red,
        ),
        Container(
          child: Text(text, textScaleFactor: 1.5,),
          alignment: Alignment.center,
        ),
        if(subtext != null) Container(
          child: Text(subtext),
          alignment: Alignment.center,
        )
      ],
    );
  }
}