import 'package:flutter/material.dart';
import 'package:mega/components/texts/BigText.dart';
import 'package:mega/components/cards/CardGrid.dart';
import 'package:mega/components/bars/MyAppBars.dart';
import 'package:mega/components/inputs/SearchInput.dart';
import 'package:mega/models/CommunityModel.dart';
import 'package:mega/services/api/CommunityAPI.dart';

import 'add/AddCommunityScreen.dart';
import 'details/CommunityDetailScreen.dart';

class HomeScreen extends StatefulWidget{
  static const routeName = '/home';

  @override
  _HomeScreenState createState()=> _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  Future<List<CommunityModel>> communities;
  String searchVal;

  void onSearch(String val){
    setState(() {
      searchVal = val;
    });
  }

  void tapCardCallback(BuildContext context, dynamic item){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CommunityDetailScreen(community: item,)),
    );
  }

  @override
  Widget build(BuildContext context){
    if (searchVal == null) communities = CommunityAPI.getCommunities(context);
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
                    list: searchVal == null ?
                      snapshot.data : snapshot.data.where((element) => element.name.toLowerCase().contains(searchVal)).toList(),
                    addButtonCallback: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddCommunityScreen()),
                      );
                    },
                    emptyText: 'No communities',
                    tapCardCallback: tapCardCallback,
                  );
                } else if (snapshot.hasError){
                  _widget = Text('Error');
                } else {
                  _widget = CircularProgressIndicator();
                }
                return _widget;
              },
            ),
          ],
        ),
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
      ),
    );
  }
}