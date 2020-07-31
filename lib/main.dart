import 'package:flutter/material.dart';
import 'package:mega/screens/LoginScreen.dart';
import 'package:mega/screens/WelcomeScreen.dart';
import 'package:mega/services/api.dart';

void main()=>runApp(MegaApp());

class MegaApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Mega App',
      initialRoute: '/',
      routes: {
        WelcomeScreen.routeName: (context) => WelcomeScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
      },
    );
  }
}