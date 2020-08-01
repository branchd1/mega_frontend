import 'package:flutter/material.dart';
import 'package:mega/components/BigText.dart';
import 'package:mega/components/MyAppBar.dart';
import 'package:mega/components/forms/WelcomeForm.dart';

class HomeScreen extends StatelessWidget{
  static const routeName = '/home';

  @override
  Widget build(BuildContext context){
    return(
        Scaffold(
            appBar: myAppBar2(),
            body: Padding(
              child: Column(
                children: <Widget>[
                  BigText(
                      text: 'Your communities'
                  ),
                  Center(
                      child: Column(
                        children: <Widget>[
//                          Padding(
//                            child: SearchBar(),
//                            padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
//                          )
                        ],
                      )
                  ),
                ],
              ),
              padding: EdgeInsets.all(30),
            )
        )
    );
  }
}