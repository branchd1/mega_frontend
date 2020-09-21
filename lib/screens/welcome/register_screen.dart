import 'package:flutter/material.dart';
import 'package:mega/components/texts/big_text.dart';
import 'package:mega/components/bars/my_app_bars.dart';
import 'package:mega/forms/register_form.dart';

/// Register screen
///
/// The screen where the user registers an account
class RegisterScreen extends StatelessWidget{

  /// The users email
  final String email;

  const RegisterScreen({Key key, @required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return(
      Scaffold(
          appBar: MyAppBars.myAppBar1(),
          body: Padding(
            child: Column(
              children: <Widget>[
                Image.asset('assets/img/logo/logo.png'),
                Column(
                  children: <Widget>[
                    BigText(text:'Register'),
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(email + ' does not exist on the database. Register below.')
                    ),
                    Padding(
                      child: RegisterForm(
                        email: email
                      ),
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                    )
                  ],
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          )
      )
    );
  }
}