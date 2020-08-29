import 'package:flutter/material.dart';
import 'package:mega/components/bars/my_bottom_nav.dart';
import 'package:mega/components/texts/big_text.dart';
import 'package:mega/components/cards/my_card_grid.dart';
import 'package:mega/components/bars/my_app_bars.dart';
import 'package:mega/components/inputs/search_input.dart';
import 'package:mega/models/community_model.dart';
import 'package:mega/services/api/community_api.dart';

import '../home/add/add_community_screen.dart';

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
    );
  }
}