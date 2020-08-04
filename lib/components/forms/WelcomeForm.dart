import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mega/models/response/EmailExistsResponseModel.dart';
import 'package:mega/screens/welcome/LoginScreen.dart';
import 'package:mega/screens/welcome/RegisterScreen.dart';
import 'package:mega/services/api/AuthAPI.dart';

import '../inputs/MyEmailInput.dart';
import '../buttons/MySubmitButton.dart';

class WelcomeForm extends StatefulWidget{
  @override
  _WelcomeFormState createState() => _WelcomeFormState();
}

class _WelcomeFormState extends State<WelcomeForm>{
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void submit() async {
    if (_formKey.currentState.validate()){
      // check email
       EmailExistsResponseModel _res = await AuthAPI.checkEmailExists(context, _emailController.text);

      // check successful
      if(_res!= null && _res.exists){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen(email: _emailController.text)),
        );
      } else if (_res!= null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegisterScreen(email: _emailController.text)),
        );
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