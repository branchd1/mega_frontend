import 'package:flutter/material.dart';
import 'package:mega/models/state_models/auth_token_state_model.dart';
import 'package:mega/models/response_models/login_response_model.dart';
import 'package:mega/screens/home/home_screen.dart';
import 'package:mega/services/api/auth_api.dart';
import 'package:mega/services/custom_types.dart';
import 'package:provider/provider.dart';

void doLogin(BuildContext context, String email, String password, {SetErrorTextCallback setErrorText}) async {
  // do login
  LoginResponseModel _res = await AuthAPI.login(context, email, password, setErrorText: setErrorText);

  // check successful login
  if(_res != null){
    Provider.of<AuthTokenStateModel>(context, listen: false).setToken(_res.authToken);
    Navigator.pushNamed(
      context,
      HomeScreen.routeName,
    );
  }
}