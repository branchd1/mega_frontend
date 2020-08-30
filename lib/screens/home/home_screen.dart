import 'package:flutter/material.dart';
import 'package:mega/components/menu.dart';
import 'package:mega/components/texts/big_text.dart';
import 'package:mega/components/cards/my_card_grid.dart';
import 'package:mega/components/bars/my_app_bars.dart';
import 'package:mega/components/inputs/search_input.dart';
import 'package:mega/models/community_model.dart';
import 'package:mega/services/api/community_api.dart';

import 'add/add_community_screen.dart';
import 'details/community_detail_screen.dart';

class HomeScreen extends StatefulWidget{
  static const routeName = '/home';

  @override
  _HomeScreenState createState()=> _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
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
    Future<List<CommunityModel>> communities;

    if (searchVal == null) communities = CommunityAPI.getCommunities(context);

    return Scaffold(
      appBar: MyAppBars.myAppBar2(),
      drawer: Menu(),
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
                  _widget = MyCardGrid(
                    list: searchVal == null ?
                      snapshot.data : snapshot.data.where((element) => element.name.toLowerCase().contains(searchVal)).toList(),
                    addButtonCallback: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddCommunityScreen()),
                      );
                    },
                    emptyText: 'No communities',
                    emptySubtext: 'add below',
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