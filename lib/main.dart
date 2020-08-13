import 'package:flutter/material.dart';
import 'package:mega/models/auth_token_model.dart';
import 'package:mega/models/feature_screen_back_button_model.dart';
import 'package:mega/screens/home/home_screen.dart';
import 'package:mega/screens/welcome/welcome_screen.dart';
import 'package:provider/provider.dart';

void main()=>runApp(MegaApp());

class MegaApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MultiProvider(
      providers: [
        Provider(create: (context) => AuthTokenModel()),
        ChangeNotifierProvider(create: (context) => FeatureScreenBackButtonModel()),
      ],
      child: MaterialApp(
        title: 'Mega App',
        theme: ThemeData(
          canvasColor: Colors.white,
        ),
        home: WelcomeScreen(),
        routes: {
          HomeScreen.routeName: (context) => HomeScreen(),
        },
      ),
    );
  }
}