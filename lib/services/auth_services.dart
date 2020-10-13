import 'package:flutter/material.dart';
import 'package:mega/models/state_models/auth_token_state_model.dart';
import 'package:mega/screens/welcome/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:mega/models/response_models/login_response_model.dart';
import 'package:mega/screens/home/home_screen.dart';
import 'package:mega/services/api/auth_api.dart';
import 'package:mega/services/type_defs.dart';

/// Logout from app
void doLogout(BuildContext context) {
  // clear the saved token
  Provider.of<AuthTokenStateModel>(context, listen: false).clearToken();

  // push to welcome screen
  Navigator.pushNamedAndRemoveUntil(
    context,
    WelcomeScreen.routeName,
    (Route<dynamic> route) => false
  );
}

/// Login
void doLogin(BuildContext context, String email, String password, {SetErrorTextCallback setErrorText}) async {
  // do login
  LoginResponseModel _res = await AuthAPI.login(context, email, password, setErrorText: setErrorText);

  // check successful login
  if(_res != null){
    // store token in memory
    Provider.of<AuthTokenStateModel>(context, listen: false).setToken(_res.authToken);

    // go to home
    Navigator.pushNamed(
      context,
      HomeScreen.routeName,
    );
  }
}