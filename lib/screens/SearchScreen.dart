import 'package:flutter/material.dart';
import 'package:mega/components/bars/MyBottomNav.dart';
import 'package:mega/components/texts/BigText.dart';
import 'package:mega/components/cards/CardGrid.dart';
import 'package:mega/components/bars/MyAppBars.dart';
import 'package:mega/components/inputs/SearchInput.dart';
import 'package:mega/models/CommunityModel.dart';
import 'package:mega/services/api/CommunityAPI.dart';

import 'AddCommunityScreen.dart';

class SearchScreen extends StatefulWidget{
  static const routeName = '/search';

  @override
  _SearchScreenState createState()=> _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>{
  Future<List<CommunityModel>> communities;
  String searchVal;

  void onSearch(String val){
    setState(() {
      searchVal = val;
    });
  }

  @override
  Widget build(BuildContext context){
    if (searchVal == null) communities = CommunityAPI.getCommunities(context);
    return Scaffold(
        appBar: MyAppBars.myAppBar2(),
        body: Padding(
          child: Column(
            children: <Widget>[
              BigText('Discover communities'),
//              Padding(
//                child: SearchInput(
//                  onChangeCallback: onSearch,
//                ),
//                padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
//              ),
//              FutureBuilder<List<CommunityModel>>(
//                future: communities,
//                builder: (BuildContext context, AsyncSnapshot<List<CommunityModel>> snapshot) {
//                  Widget _widget;
//                  if(snapshot.hasData){
//                    _widget = CardGrid(
//                      list: searchVal == null ?
//                      snapshot.data : snapshot.data.where((element) => element.name.toLowerCase().contains(searchVal)).toList(),
//                      addButtonCallback: (){
//                        Navigator.push(
//                          context,
//                          MaterialPageRoute(builder: (context) => AddCommunityScreen()),
//                        );
//                      },
//                      emptyText: 'No communities',
//                    );
//                  } else if (snapshot.hasError){
//                    _widget = Text('Error');
//                  } else {
//                    _widget = CircularProgressIndicator();
//                  }
//                  return _widget;
//                },
//              ),
            ],
          ),
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        ),
        bottomNavigationBar: MyBottomNav(
            bottomNavActivePage: BottomNavActivePage.search
        )
    );
  }
}