import 'package:flutter/material.dart';
import 'package:mega/components/texts/big_text.dart';
import 'package:mega/components/bars/my_app_bars.dart';
import 'package:mega/forms/edit_profile_form.dart';
import 'package:mega/models/user_model.dart';
import 'package:mega/services/api/auth_api.dart';

class EditProfileScreen extends StatelessWidget{

  final UserModel user;

  const EditProfileScreen({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context){

    return Scaffold(
        appBar: MyAppBars.myAppBar2(),
        body: Padding(
          child: Column(
            children: <Widget>[
              BigText(text:'Edit profile'),
              Padding(
                child: ProfileForm(user: user,),
                padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
              ),
            ],
          ),
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        ),
    );
  }
}