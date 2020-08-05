import 'package:flutter/material.dart';

typedef void OnPressCallback();

class MyButton extends StatelessWidget{
  final String buttonText;

  final OnPressCallback onPressCallback;

  MyButton({Key key, @required this.buttonText, this.onPressCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(buttonText),
      onPressed: onPressCallback
    );
  }
}