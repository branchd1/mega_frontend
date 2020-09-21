import 'package:flutter/material.dart';
import 'package:mega/components/buttons/my_submit_button.dart';
import 'package:mega/components/inputs/my_email_input.dart';
import 'package:mega/models/response_models/email_exists_response_model.dart';
import 'package:mega/screens/welcome/login_screen.dart';
import 'package:mega/screens/welcome/register_screen.dart';
import 'package:mega/services/api/auth_api.dart';

/// Form used to welcome user
/// Checks if user email already used in database to
/// decide if user needs to register or login
class WelcomeForm extends StatefulWidget{
  @override
  _WelcomeFormState createState() => _WelcomeFormState();
}

class _WelcomeFormState extends State<WelcomeForm>{
  /// Controls user email
  final TextEditingController _emailController = TextEditingController();

  /// The form key
  /// Unique globally
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// Submit the form
  Future<void> submit() async {
    // validate the form
    if (_formKey.currentState.validate()){
      // check email exists in database
       EmailExistsResponseModel _res = await AuthAPI.checkEmailExists(context, _emailController.text);

      // if successful navigate to login or register screen
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
              buttonText: 'Sign up/Login',
              submitCallback: submit
            )
          ),
        ],
      )
    );
  }
}