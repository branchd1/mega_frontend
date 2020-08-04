import 'package:flutter/material.dart';
import 'package:mega/components/bars/MyAppBars.dart';
import 'package:mega/components/bars/MyBottomNav.dart';
import 'package:mega/components/cards/CardGrid.dart';
import 'package:mega/components/inputs/SearchInput.dart';
import 'package:mega/components/texts/BigText.dart';
import 'package:mega/models/CommunityModel.dart';
import 'package:mega/models/FeatureModel.dart';
import 'package:mega/services/api/FeatureAPI.dart';

class AddFeatureScreen extends StatefulWidget {
  final CommunityModel community;

  const AddFeatureScreen({Key key, this.community}) : super(key: key);

  @override
  _AddFeatureScreenState createState()=> _AddFeatureScreenState();
}

class _AddFeatureScreenState extends State<AddFeatureScreen>{
  Future<List<FeatureModel>> features;
  String searchVal;

  void onSearch(String val){
    setState(() {
      searchVal = val;
    });
  }

  void tapCardCallback(BuildContext context, dynamic item){
//    Navigator.push(
//      context,
//      MaterialPageRoute(builder: (context) => FeatureDetailAddScreen()),
//    );
  }

  @override
  Widget build(BuildContext context) {
    if (searchVal == null) features = FeatureAPI.getAllFeatures(context, widget.community.type, widget.community.id);
    return Scaffold(
        appBar: MyAppBars.myAppBar3(),
        body: Padding(
          child: Column(
            children: <Widget>[
              BigText('Features'),
              Align(
                child: Text(
                  this.widget.community.type,
                  textAlign: TextAlign.left,
                ),
                alignment: Alignment.bottomLeft,
              ),
              Padding(
                child: SearchInput(
                  onChangeCallback: onSearch,
                ),
                padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
              ),
              FutureBuilder<List<FeatureModel>>(
                future: features,
                builder: (BuildContext context, AsyncSnapshot<List<FeatureModel>> snapshot) {
                  Widget _widget;
                  if(snapshot.hasData){
                    _widget = CardGrid(
                      list: searchVal == null ?
                      snapshot.data : snapshot.data.where((element) => element.name.toLowerCase().contains(searchVal)).toList(),
                      emptyText: 'No features',
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
        bottomNavigationBar: MyBottomNav(
            bottomNavActivePage: BottomNavActivePage.home
        )
    );
  }
}