import 'package:flutter/material.dart';
import 'package:mega/components/bars/MyBottomNav.dart';
import 'package:mega/components/texts/BigText.dart';
import 'package:mega/components/cards/CardGrid.dart';
import 'package:mega/components/bars/MyAppBars.dart';
import 'package:mega/components/inputs/SearchInput.dart';
import 'package:mega/models/CommunityModel.dart';
import 'package:mega/services/api/CommunityAPI.dart';

import 'AddCommunityScreen.dart';

class HomeScreen extends StatefulWidget{
  static const routeName = '/home';

  @override
  _HomeScreenState createState()=> _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  Future<List<CommunityModel>> communities;
  bool isSearch = false;

  void onSearch(String val){
    setState(() {
      isSearch = val != null ?  true : false;
    });
  }

  @override
  Widget build(BuildContext context){
    if (!isSearch) communities = CommunityAPI.getCommunities(context);
    return Scaffold(
      appBar: MyAppBars.myAppBar2(),
      body: Padding(
        child: Column(
          children: <Widget>[
            BigText('Your communities'),
            Padding(
              child: SearchInput(
                onChangeCallback: onSearch,
              ),
              padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
            ),
            FutureBuilder<List<CommunityModel>>(
              future: communities,
              builder: (BuildContext context, AsyncSnapshot<List<CommunityModel>> snapshot) {
                Widget _widget;
                if(snapshot.hasData){
                  _widget = CardGrid(
                    list: snapshot.data,
                    addButtonCallback: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddCommunityScreen()),
                      );
                    },
                  );
                } else if (snapshot.hasError){
                  _widget = Text('Error');
                } else {
                  _widget = Text('loading...');
                }
                return _widget;
              },
            ),
          ],
        ),
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
      ),
      bottomNavigationBar: MyBottomNav()
    );
  }
}