import 'package:flutter/material.dart';
import 'package:mega/components/bars/MyBottomNav.dart';
import 'package:mega/components/texts/BigText.dart';
import 'package:mega/components/cards/CardGrid.dart';
import 'package:mega/components/bars/MyAppBars.dart';
import 'package:mega/components/inputs/SearchInput.dart';
import 'package:mega/models/CommunityModel.dart';
import 'package:mega/services/api/CommunityAPI.dart';

import '../home/add/AddCommunityScreen.dart';

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
            ],
          ),
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        ),
        bottomNavigationBar: MyBottomNav(
            bottomNavActivePage: BottomNavActivePage.profile
        )
    );
  }
}