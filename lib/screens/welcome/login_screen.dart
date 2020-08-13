import 'package:flutter/material.dart';
import 'package:mega/components/texts/big_text.dart';
import 'package:mega/components/bars/my_app_bars.dart';
import 'package:mega/components/forms/login_form.dart';

//class LoginScreenArguments {
//  final String email;
//
//  LoginScreenArguments({this.email});
//}

class LoginScreen extends StatelessWidget{
//  static const routeName = '/login';

  final String email;

  const LoginScreen({this.email});

  @override
  Widget build(BuildContext context){
//    final LoginScreenArguments args = ModalRoute.of(context).settings.arguments;
    return(
        Scaffold(
          appBar: MyAppBars.myAppBar1(),
          body: Padding(
            child: Column(
              children: <Widget>[
                Image.asset('assets/img/logo/logo.png'),
                Column(
                  children: <Widget>[
                    BigText('Login'),
                    Padding(
                      child: LoginForm(
                          email: email
                      ),
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
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