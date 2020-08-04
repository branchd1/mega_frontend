import 'package:flutter/material.dart';
import 'package:mega/models/AuthTokenModel.dart';
import 'package:mega/screens/home/HomeScreen.dart';
import 'package:mega/screens/welcome/WelcomeScreen.dart';
import 'package:provider/provider.dart';

void main()=>runApp(
  MultiProvider(
    providers: [
      Provider(create: (context) => AuthTokenModel()),
    ],
    child: MegaApp(),
  ),
);

class MegaApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Mega App',
      theme: ThemeData(
        canvasColor: Colors.white,
      ),
      home: WelcomeScreen(),
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
      },
    );
  }
}