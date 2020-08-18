import 'package:flutter/material.dart';
import 'package:mega/services/callback_types.dart';

class MySubmitButton extends StatelessWidget{
  final String buttonText;

  final NoArgNoReturnCallback submitCallback;

  MySubmitButton({Key key, @required this.buttonText, this.submitCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Column(
        children: <Widget>[
          Icon(Icons.arrow_forward),
          Text(buttonText)
        ],
      ),
      onPressed: submitCallback,
    );
  }
}