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
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => WelcomeScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/login': (context) => LoginScreen(),
      },
    );
  }
}