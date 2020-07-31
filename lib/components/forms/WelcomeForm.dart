import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mega/models/EmailExistsResponse.dart';
import 'package:mega/screens/LoginScreen.dart';
import 'package:mega/services/api.dart';

import '../ErrorSnackBar.dart';
import '../inputs/MyEmailInput.dart';
import '../MySubmitButton.dart';

class WelcomeForm extends StatefulWidget{
  @override
  _WelcomeFormState createState() => _WelcomeFormState();
}

class _WelcomeFormState extends State<WelcomeForm>{
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void submit() async {
    if (_formKey.currentState.validate()){
      EmailExistsResponse _res;

      // check email
      _res = await API(
        context: context
      ).checkEmailExists(_emailController.text);

      // check successful
      if(_res!= null && _res.exists){
        Navigator.pushNamed(context,
          LoginScreen.routeName,
          arguments: ScreenArguments(
            email: _emailController.text,
          ),
        );
      } else if (_res!= null) {
        Navigator.pushNamed(context, '/register');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            MyEmailInput(
                controller: _emailController
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: MySubmitButton(
                    buttonText: 'Go',
                    submitCallback: submit
                )
            ),
          ],
        )
    );
  }
}