import 'package:flutter/material.dart';
import 'package:mega/components/BigText.dart';
import 'package:mega/components/MyAppBar.dart';
import 'package:mega/components/forms/WelcomeForm.dart';

class HomeScreen extends StatelessWidget{
//  static const routeName = '/home';

  @override
  Widget build(BuildContext context){
    return(
        Scaffold(
            appBar: myAppBar2(),
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