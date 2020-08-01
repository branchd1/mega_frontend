import 'package:flutter/material.dart';
import 'package:mega/models/AuthTokenModel.dart';
import 'package:mega/screens/LoginScreen.dart';
import 'package:mega/screens/RegisterScreen.dart';
import 'package:mega/screens/WelcomeScreen.dart';
import 'package:provider/provider.dart';

void main()=>runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthTokenModel()),
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
      home: WelcomeScreen()
//      initialRoute: '/',
//      routes: {
//        WelcomeScreen.routeName: (context) => WelcomeScreen(),
//        LoginScreen.routeName: (context) => LoginScreen(),
//        RegisterScreen.routeName: (context) => RegisterScreen(),
//      },
    );
  }
}