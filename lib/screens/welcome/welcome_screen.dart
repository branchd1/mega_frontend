import 'package:flutter/material.dart';
import 'package:mega/components/texts/big_text.dart';
import 'package:mega/components/bars/my_app_bars.dart';
import 'package:mega/forms/welcome_form.dart';
import 'package:mega/models/state_models/auth_token_state_model.dart';
import 'package:mega/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatelessWidget{
  static const routeName = '/';

  @override
  Widget build(BuildContext context){

    Provider.of<AuthTokenStateModel>(context, listen: false).checkAndGetToken().then((value){
      if (value != null){
        WidgetsBinding.instance.addPostFrameCallback((_){
          Navigator.pushReplacementNamed(
            context,
            HomeScreen.routeName,
          );
        });
        return Container();
      }
    });

    return(
      Scaffold(
        appBar: MyAppBars.myAppBar1(),
        body: Padding(
          child: Column(
            children: <Widget>[
              Image.asset('assets/img/logo/logo.png'),
              Column(
                children: <Widget>[
                  BigText(text:'Welcome'),
                  Padding(
                    child: WelcomeForm(),
                    padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                  ),
                ],
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        ),
      )
    );
  }
}