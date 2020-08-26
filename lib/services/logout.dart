import 'package:flutter/material.dart';
import 'package:mega/models/state_models/auth_token_state_model.dart';
import 'package:mega/models/response_models/login_response_model.dart';
import 'package:mega/screens/home/home_screen.dart';
import 'package:mega/screens/welcome/welcome_screen.dart';
import 'package:mega/services/api/auth_api.dart';
import 'package:mega/services/callback_types.dart';
import 'package:provider/provider.dart';

void doLogout(BuildContext context) {
  Provider.of<AuthTokenStateModel>(context, listen: false).clearToken();

  Navigator.pushNamedAndRemoveUntil(
    context,
    WelcomeScreen.routeName,
    (Route<dynamic> route) => false
  );
}