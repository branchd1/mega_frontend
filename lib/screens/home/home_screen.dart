import 'package:flutter/material.dart';
import 'package:mega/components/my_menu.dart';
import 'package:mega/components/texts/big_text.dart';
import 'package:mega/components/cards/my_card_grid.dart';
import 'package:mega/components/bars/my_app_bars.dart';
import 'package:mega/components/inputs/search_input.dart';
import 'package:mega/components/texts/error_text_with_icon.dart';
import 'package:mega/models/community_model.dart';
import 'package:mega/services/api/community_api.dart';

import 'add/add_community_screen.dart';
import 'community_screen.dart';

/// The home screen which lists all the users communities
class HomeScreen extends StatefulWidget{
  /// The home screen route name
  static const routeName = '/home';

  @override
  _HomeScreenState createState()=> _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  /// search bar value
  String searchVal;

  /// Update list when search bar value changes
  void onSearch(String val){
    setState(() {
      searchVal = val;
    });
  }

  /// Callback when community card tapped
  ///
  /// Goes to community screen when the community's card is tapped
  void tapCardCallback(BuildContext context, dynamic item){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CommunityScreen(community: item,)),
    );
  }

//  /// refresh widget
//  Future<void> refresh() async {
//    setState(() {});
//  }

  @override
  Widget build(BuildContext context){
    Future<List<CommunityModel>> communities;

    // get communities
    if (searchVal == null) communities = CommunityAPI.getCommunities(context);

    return Scaffold(
      appBar: MyAppBars.myAppBar2(),
      drawer: MyMenu(),
      body: Padding(
        child: Column(
          children: <Widget>[
            BigText(text:'Your communities'),
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
                  _widget = Expanded(
                    child: MyCardGrid(
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
                    ),
                  );
                } else if (snapshot.hasError){
                  _widget = ErrorTextWithIcon(text: 'Cannot retrieve communities', subtext: 'Try again',);
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