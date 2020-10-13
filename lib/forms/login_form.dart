import 'package:flutter/material.dart';
import 'package:mega/components/buttons/my_submit_button.dart';
import 'package:mega/components/inputs/my_password_input.dart';
import 'package:mega/services/auth_services.dart';

/// Form used to login
class LoginForm extends StatefulWidget{
  // Users email
  final String email;

  LoginForm({@required this.email});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm>{
  /// Controls user password
  final TextEditingController _passwordController = TextEditingController();

  /// The form key
  /// Unique globally
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// Error text displayed at the bottom
  String _errorText;

  /// Set the error text
  void setErrorText(text){
    setState(() {
      _errorText = text;
    });
  }


  /// Submit the form
  Future<void> submit() {
    if (_formKey.currentState.validate()){
      // do the login
      doLogin(
          context,
          this.widget.email,
          _passwordController.text,
          setErrorText: setErrorText
      );
    }
    return null;
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