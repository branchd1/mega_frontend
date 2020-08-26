import 'package:flutter/material.dart';
import 'package:mega/components/texts/big_text.dart';
import 'package:mega/components/bars/my_app_bars.dart';
import 'package:mega/forms/welcome_form.dart';

class WelcomeScreen extends StatelessWidget{
  static const routeName = '/';

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
                  BigText('Welcome'),
                  Padding(
                    child: WelcomeForm(),
                    padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                  )
                ],
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        ),
      )
    );
  }
}