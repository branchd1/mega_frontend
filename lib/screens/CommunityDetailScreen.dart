import 'package:flutter/material.dart';
import 'package:mega/components/bars/MyAppBars.dart';
import 'package:mega/components/bars/MyBottomNav.dart';
import 'package:mega/models/CommunityModel.dart';

class CommunityDetailScreen extends StatefulWidget{
  final CommunityModel community;

  const CommunityDetailScreen({Key key, this.community}) : super(key: key);

  @override
  _CommunityDetailScreenState createState()=>_CommunityDetailScreenState();
}

class _CommunityDetailScreenState extends State<CommunityDetailScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBars.myAppBar3(),
      body: Container(),
      bottomNavigationBar: MyBottomNav(
          bottomNavActivePage: BottomNavActivePage.home
      )
    );
  }
}