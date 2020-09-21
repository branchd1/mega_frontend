import 'package:flutter/material.dart';
import 'package:mega/components/buttons/my_reset_password_button.dart';
import 'package:mega/components/texts/big_text.dart';
import 'package:mega/components/bars/my_app_bars.dart';
import 'package:mega/forms/login_form.dart';

/// Login screen
///
/// The screen where the user logs in
class LoginScreen extends StatelessWidget{

  /// The users email
  final String email;

  const LoginScreen({this.email});

  @override
  Widget build(BuildContext context){
    return(
        Scaffold(
          appBar: MyAppBars.myAppBar1(),
          body: Padding(
            child: Column(
              children: <Widget>[
                Image.asset('assets/img/logo/logo.png'),
                Column(
                  children: <Widget>[
                    BigText(text:'Login'),
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(email + ' is already registered. Login below.')
                    ),
                    Padding(
                      child: LoginForm(
                          email: email
                      ),
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                    ),
                    Align(
                      child: MyResetPasswordButton(email: email,),
                      alignment: Alignment.bottomLeft,
                    )
                  ],
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          )
        )
    );
  }
}