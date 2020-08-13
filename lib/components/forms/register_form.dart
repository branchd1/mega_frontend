import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mega/components/forms/login_form.dart';
import 'package:mega/components/texts/error_text.dart';
import 'package:mega/models/auth_token_model.dart';
import 'package:mega/models/response/login_response_model.dart';
import 'package:mega/models/response/register_response_model.dart';
import 'package:mega/services/api/base_api.dart';
import 'package:mega/services/api/auth_api.dart';
import 'package:provider/provider.dart';

import '../bars/error_snack_bar.dart';
import '../inputs/my_password_input.dart';
import '../buttons/my_submit_button.dart';

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
            child: ErrorText(_errorText),
          )
        ],
      )
    );
  }
}