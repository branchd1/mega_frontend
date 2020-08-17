import 'package:flutter/material.dart';
import 'package:mega/services/validators.dart';

class MyPasswordInput extends StatelessWidget{
  final TextEditingController controller;

  MyPasswordInput({@required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'password *',
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
        ),
        validator: (val)=>Validators.minLengthValidator(val, 8),
        obscureText: true,
      ),
    );
  }
}