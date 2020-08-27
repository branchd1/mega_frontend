import 'package:flutter/material.dart';
import 'package:mega/components/bars/my_bottom_nav.dart';
import 'package:mega/components/texts/big_text.dart';
import 'package:mega/components/cards/card_grid.dart';
import 'package:mega/components/bars/my_app_bars.dart';
import 'package:mega/components/inputs/search_input.dart';
import 'package:mega/forms/profile_form.dart';
import 'package:mega/models/community_model.dart';
import 'package:mega/models/user_model.dart';
import 'package:mega/services/api/auth_api.dart';
import 'package:mega/services/api/community_api.dart';

import '../home/add/add_community_screen.dart';

class ProfileScreen extends StatelessWidget{
  static const routeName = '/profile';

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: MyAppBars.myAppBar2(),
        body: Padding(
          child: Column(
            children: <Widget>[
              BigText('Your profile'),
              Padding(
                child: ProfileForm(),
                padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
              ),
            ],
          ),
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        ),
    );
  }
}