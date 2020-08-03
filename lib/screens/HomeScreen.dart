import 'package:flutter/material.dart';
import 'package:mega/components/bars/MyBottomNav.dart';
import 'package:mega/components/texts/BigText.dart';
import 'package:mega/components/cards/CardGrid.dart';
import 'package:mega/components/bars/MyAppBar.dart';
import 'package:mega/components/inputs/SearchInput.dart';
import 'package:mega/models/CommunityModel.dart';
import 'package:mega/services/api/CommunityAPI.dart';

class HomeScreen extends StatelessWidget{
  static const routeName = '/home';

  @override
  Widget build(BuildContext context){
    final Future<List<CommunityModel>> communities = CommunityAPI.getCommunities(context);
    return Scaffold(
      appBar: myAppBar2(),
      body: Padding(
        child: Column(
          children: <Widget>[
            BigText('Your communities'),
            Padding(
              child: SearchInput(),
              padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
            ),
            FutureBuilder<List<CommunityModel>>(
              future: communities,
              builder: (BuildContext context, AsyncSnapshot<List<CommunityModel>> snapshot) {
                Widget _widget;
                if(snapshot.hasData){
                  _widget = CardGrid(
                    list: snapshot.data
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
        padding: EdgeInsets.all(30),
      ),
      bottomNavigationBar: MyBottomNav()
    );
  }
}