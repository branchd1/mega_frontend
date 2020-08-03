import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mega/models/AuthTokenModel.dart';
import 'package:mega/models/response/LoginResponseModel.dart';
import 'package:mega/screens/HomeScreen.dart';
import 'package:mega/services/api/BaseAPI.dart';
import 'package:mega/services/api/AuthAPI.dart';
import 'package:provider/provider.dart';

import '../ErrorSnackBar.dart';
import '../inputs/MyPasswordInput.dart';
import '../MySubmitButton.dart';

typedef void SetErrorTextCallback(String text);

void doLogin(BuildContext context, String email, String password, {SetErrorTextCallback setErrorText}) async {
  // do login
  LoginResponseModel _res = await AuthAPI.login(context, email, password, setErrorText: setErrorText);

  // check successful login
  if(_res != null){
    Provider.of<AuthTokenModel>(context, listen: false).setToken(_res.auth_token);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }
}

class LoginForm extends StatefulWidget{
  final String email;
  LoginForm({this.email});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm>{
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _errorText;

  void setErrorText(text){
    setState(() {
      _errorText = text;
    });
  }

  void submit() {
    if (_formKey.currentState.validate()){
      doLogin(
          context,
          this.widget.email,
          _passwordController.text,
          setErrorText: setErrorText
      );
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
              buttonText: 'Login',
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