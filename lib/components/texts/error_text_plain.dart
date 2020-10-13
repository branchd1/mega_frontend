import 'package:flutter/material.dart';

/// Widget displays an error message in red text
class ErrorTextPlain extends StatelessWidget{
  /// The main error text
  final String text;

  const ErrorTextPlain(this.text, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.left,
      style: TextStyle(
        // make the text red
        color: Colors.red
      ),
    );
  }
}