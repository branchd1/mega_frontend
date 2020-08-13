import 'package:flutter/material.dart';

class MyEmailInput extends StatelessWidget{
  final TextEditingController controller;

  MyEmailInput({@required this.controller});

  final RegExp emailRegex = RegExp(
    r"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$",
    caseSensitive: false,
    multiLine: false,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'email *',
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
        ),
        validator: (String value) {
          return emailRegex.hasMatch(value) ? null : 'Enter a valid email';
        },
      ),
    );
  }
}