import 'package:flutter/material.dart';

///  Widget displays a big text
class BigText extends StatelessWidget{
  /// The text content
  final String text;

  BigText({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Text(
        text,
        // make the text big
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