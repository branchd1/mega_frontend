import 'package:flutter/material.dart';
import 'package:mega/services/validators.dart';

class MyEmailInput extends StatelessWidget{
  final TextEditingController controller;

  MyEmailInput({@required this.controller});

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
        validator: Validators.emailValidator,
      ),
    );
  }
}