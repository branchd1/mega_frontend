import 'package:flutter/material.dart';
import 'package:mega/models/state_models/auth_token_state_model.dart';
import 'package:mega/models/state_models/current_community_state_model.dart';
import 'package:mega/models/state_models/current_feature_state_model.dart';
import 'package:mega/models/state_models/feature_screen_back_button_state_model.dart';
import 'package:mega/screens/home/home_screen.dart';
import 'package:mega/screens/welcome/welcome_screen.dart';
import 'package:provider/provider.dart';

void main()=>runApp(MegaApp());

class MegaApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MultiProvider(
      providers: [
        Provider(create: (context) => AuthTokenStateModel()),
        Provider(create: (context) => CurrentCommunityStateModel()),
        Provider(create: (context) => CurrentFeatureStateModel()),
        ChangeNotifierProvider(create: (context) => FeatureScreenBackButtonStateModel()),
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