import 'package:flutter/material.dart';
import 'package:mega/services/type_defs.dart';

/// Widget representing text input
class MyTextInput extends StatelessWidget{
  /// Text controller used to track changes in the input
  final TextEditingController controller;

  /// The input placeholder
  final String hintText;

  /// Callback to validate the input value
  final ValidatorCallback validator;

  MyTextInput({@required this.controller, @required this.hintText, this.validator});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
        ),
        validator: validator,
      ),
    );
  }
}