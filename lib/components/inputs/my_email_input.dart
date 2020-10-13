import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mega/services/validators.dart';

/// Widget representing email input
class MyEmailInput extends StatelessWidget{
  /// Text controller used to track changes in the email input
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
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp("[ ]"))
        ],
      ),
    );
  }
}