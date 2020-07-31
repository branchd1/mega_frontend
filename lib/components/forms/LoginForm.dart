import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mega/models/LoginResponse.dart';
import 'package:mega/services/api.dart';

import '../ErrorSnackBar.dart';
import '../inputs/MyPasswordInput.dart';
import '../MySubmitButton.dart';

class LoginForm extends StatefulWidget{
  final String email;
  LoginForm({this.email});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm>{
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void submit() async {
    if (_formKey.currentState.validate()){
      LoginResponse _res;

      // do login
      await API(
        context:context
      ).login(this.widget.email, _passwordController.text);

      // check successful login
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            MyPasswordInput(
              controller: _passwordController
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: MySubmitButton(
                buttonText: 'Login',
                submitCallback: submit
              )
            ),
          ],
        )
    );
  }
}