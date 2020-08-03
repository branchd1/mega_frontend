import 'package:flutter/material.dart';

typedef String Validator(String text);

class MyTextInput extends StatelessWidget{
  final TextEditingController controller;
  final String hintText;
  final Validator validator;

  MyTextInput({@required this.controller, this.hintText, this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder()
      ),
      validator: validator,
    );
  }
}