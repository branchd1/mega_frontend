import 'package:flutter/material.dart';
import 'package:mega/components/texts/BigText.dart';
import 'package:mega/components/MyAppBar.dart';
import 'package:mega/components/forms/WelcomeForm.dart';

class WelcomeScreen extends StatelessWidget{
  static const routeName = '/';

  @override
  Widget build(BuildContext context){
    return(
        Scaffold(
          appBar: myAppBar1(),
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
            padding: EdgeInsets.all(30),
          )
        )
    );
  }
}