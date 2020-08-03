import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mega/components/forms/LoginForm.dart';
import 'package:mega/models/AuthTokenModel.dart';
import 'package:mega/models/response/LoginResponseModel.dart';
import 'package:mega/models/response/RegisterResponseModel.dart';
import 'package:mega/services/api/BaseAPI.dart';
import 'package:mega/services/api/AuthAPI.dart';
import 'package:provider/provider.dart';

import '../ErrorSnackBar.dart';
import '../inputs/MyPasswordInput.dart';
import '../MySubmitButton.dart';

typedef void SetErrorTextCallback(String text);

class RegisterForm extends StatefulWidget{
  final String email;
  RegisterForm({this.email});

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm>{
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _errorText;

  void setErrorText(text){
    setState(() {
      _errorText = text;
    });
  }

  void submit() async {
    if (_formKey.currentState.validate()){
      // do login
      RegisterResponseModel _res = await AuthAPI.register(context, this.widget.email, _passwordController.text, setErrorText);

      // check successful registration
      if(_res != null) {
        doLogin(context, this.widget.email, _passwordController.text);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(widget.email)
          ),
          MyPasswordInput(
            controller: _passwordController
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: MySubmitButton(
              buttonText: 'Register',
              submitCallback: submit
            )
          ),
          if(_errorText!=null) Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              _errorText,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.red
              ),
            ),
          )
        ],
      )
    );
  }
}