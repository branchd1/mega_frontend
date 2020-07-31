import 'package:flutter/material.dart';

class MyPasswordInput extends StatelessWidget{
  final TextEditingController controller;

  MyPasswordInput({@required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          hintText: 'password *',
          border: OutlineInputBorder()
      ),
      validator: (String value) {
        return (value.length>5) ? null : 'Password must be more than 5 characters';
      },
      obscureText: true,
    );
  }
}