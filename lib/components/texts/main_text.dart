import 'package:flutter/material.dart';

/// Text widget with bold font
class MainText extends StatelessWidget{
  /// The content of the the widget
  final String text;

  /// Determines if the text should be centered.
  /// Defaults to false
  final bool textCenter;

  MainText({Key key, @required this.text, this.textCenter: false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      // increase font
      textScaleFactor: 1.5,
      style: TextStyle(
        // make it bold
        fontWeight: FontWeight.bold
      ),
      // align the text at the center or left depending on configuration
      textAlign: textCenter ? TextAlign.center : TextAlign.left,
    );
  }
}