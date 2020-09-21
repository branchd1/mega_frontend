import 'package:flutter/material.dart';

/// Flat button widget
class MyButton extends StatelessWidget{
  /// The button text
  final String buttonText;

  /// The callback when button is pressed
  final VoidCallback onPressCallback;

  MyButton({Key key, @required this.buttonText, this.onPressCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(buttonText),
      onPressed: onPressCallback
    );
  }
}