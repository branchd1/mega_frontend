import 'package:flutter/material.dart';

/// Widget displays an error message with an icon to improve user experience
class ErrorTextWithIcon extends StatelessWidget{
  /// The main error text
  final String text;

  /// Subtext explaining the error text
  /// or directing the user to perform some action after the error occurs
  final String subtext;

  const ErrorTextWithIcon({Key key, @required this.text, this.subtext: ''}) : super(key: key);

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
          // the large main text
          child: Text(text, textScaleFactor: 1.5,),
          alignment: Alignment.center,
        ),
        Container(
          // the subtext
          child: Text(subtext),
          alignment: Alignment.center,
        )
      ],
    );
  }
}