import 'package:flutter/material.dart';
import 'package:mega/services/validators.dart';

/// Widget representing password input
class MyPasswordInput extends StatelessWidget{
  /// Text controller used to track changes in the password input
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
        // hide the input value
        obscureText: true,
      ),
    );
  }
}