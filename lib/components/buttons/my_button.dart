import 'package:flutter/material.dart';
import 'package:mega/services/callback_types.dart';

class MyButton extends StatelessWidget{
  final String buttonText;

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