import 'package:flutter/material.dart';

class ErrorTextPlain extends StatelessWidget{
  final String errorText;

  const ErrorTextPlain(this.errorText, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      errorText,
      textAlign: TextAlign.left,
      style: TextStyle(
          color: Colors.red
      ),
    );
  }
}