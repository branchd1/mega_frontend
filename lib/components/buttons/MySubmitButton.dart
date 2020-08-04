import 'package:flutter/material.dart';

typedef void FormSubmitCallback();

class MySubmitButton extends StatelessWidget{
  final String buttonText;

  final FormSubmitCallback submitCallback;

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