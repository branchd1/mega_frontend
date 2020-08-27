import 'package:flutter/material.dart';
import 'package:mega/components/buttons/my_button.dart';
import 'package:mega/components/texts/big_text.dart';
import 'package:mega/components/bars/my_app_bars.dart';
import 'package:mega/forms/login_form.dart';
import 'package:mega/services/api/auth_api.dart';

//class LoginScreenArguments {
//  final String email;
//
//  LoginScreenArguments({this.email});
//}

class LoginScreen extends StatelessWidget{
//  static const routeName = '/login';

  final String email;

  const LoginScreen({this.email});

  void doResetPassword(BuildContext context) async {
    // reset password
    bool _res = await AuthAPI.resetPassword(context, email);
    if(_res == true){
      return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Password Reset Email Sent'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Please check your email to complete the password reset action.'),
                ],
              ),
            ),

          );
        },
      );
    }
  }

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
                    ),
                    Align(
                      child: MyButton(buttonText: 'reset password', onPressCallback: ()=>doResetPassword(context),),
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