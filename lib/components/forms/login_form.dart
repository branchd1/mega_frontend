import 'package:flutter/material.dart';
import 'package:mega/models/state_models/auth_token_state_model.dart';
import 'package:mega/models/response_models/login_response_model.dart';
import 'package:mega/screens/home/home_screen.dart';
import 'package:mega/services/api/auth_api.dart';
import 'package:mega/services/login.dart';
import 'package:provider/provider.dart';

import '../inputs/my_password_input.dart';
import '../buttons/my_submit_button.dart';

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