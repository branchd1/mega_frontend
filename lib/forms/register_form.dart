import 'package:flutter/material.dart';
import 'package:mega/components/buttons/my_submit_button.dart';
import 'package:mega/components/inputs/my_password_input.dart';
import 'package:mega/components/texts/error_text_plain.dart';
import 'package:mega/models/response_models/register_response_model.dart';
import 'package:mega/services/api/auth_api.dart';
import 'package:mega/services/auth_services.dart';

/// Form used to register
class RegisterForm extends StatefulWidget{

  /// User email
  final String email;

  RegisterForm({@required this.email});

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm>{
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
  Future<void> submit() async {
    if (_formKey.currentState.validate()){
      // do registration in server
      RegisterResponseModel _res = await AuthAPI.register(context, this.widget.email, _passwordController.text, setErrorText);

      // check successful registration and login
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
            child: ErrorTextPlain(_errorText),
          )
        ],
      )
    );
  }
}