import 'package:flutter/material.dart';

class MySubmitButton extends StatelessWidget{
  final String buttonText;

  final VoidCallback submitCallback;

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