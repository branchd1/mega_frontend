import 'package:flutter/material.dart';
import 'package:mega/components/bars/my_app_bars.dart';
import 'package:mega/components/bars/my_bottom_nav.dart';
import 'package:mega/components/cards/card_grid.dart';
import 'package:mega/components/inputs/search_input.dart';
import 'package:mega/components/texts/big_text.dart';
import 'package:mega/models/community_model.dart';
import 'package:mega/models/feature_model.dart';
import 'package:mega/services/api/feature_api.dart';

import '../details/feature_detail_add_screen.dart';

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
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FeatureDetailAddScreen(feature: item, community: this.widget.community)),
    );
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
    );
  }
}