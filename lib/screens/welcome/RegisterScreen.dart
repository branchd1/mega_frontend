import 'package:flutter/material.dart';
import 'package:mega/components/texts/BigText.dart';
import 'package:mega/components/bars/MyAppBars.dart';
import 'package:mega/components/forms/LoginForm.dart';
import 'package:mega/components/forms/RegisterForm.dart';

//class RegisterScreenArguments {
//  final String email;
//
//  RegisterScreenArguments({this.email});
//}

class RegisterScreen extends StatelessWidget{
//  static const routeName = '/register';

  final String email;

  const RegisterScreen({this.email});

  @override
  Widget build(BuildContext context){
//    final RegisterScreenArguments args = ModalRoute.of(context).settings.arguments;
    return(
        Scaffold(
            appBar: MyAppBars.myAppBar1(),
            body: Padding(
              child: Column(
                children: <Widget>[
                  Image.asset('assets/img/logo/logo.png'),
                  Column(
                    children: <Widget>[
                      BigText('Register'),
                      Padding(
                        child: RegisterForm(
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