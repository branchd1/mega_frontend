import 'package:flutter/material.dart';
import 'package:mega/components/BigText.dart';
import 'package:mega/components/forms/WelcomeForm.dart';

class WelcomeScreen extends StatelessWidget{
  static const routeName = '/';

  @override
  Widget build(BuildContext context){
    return(
        Scaffold(
            body: Padding(
              child: Column(
                children: <Widget>[
                  Image.asset('assets/img/logo/logo.png'),
                  Center(
                      child: Column(
                        children: <Widget>[
                          BigText(
                              text:'Welcome'
                          ),
                          Padding(
                            child: WelcomeForm(),
                            padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                          )
                        ],
                      )
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