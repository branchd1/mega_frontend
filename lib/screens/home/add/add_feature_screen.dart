import 'package:flutter/material.dart';
import 'package:mega/components/bars/my_app_bars.dart';
import 'package:mega/components/cards/my_card_grid.dart';
import 'package:mega/components/inputs/search_input.dart';
import 'package:mega/components/texts/big_text.dart';
import 'package:mega/components/texts/error_text_with_icon.dart';
import 'package:mega/models/community_model.dart';
import 'package:mega/models/feature_model.dart';
import 'package:mega/services/api/feature_api.dart';
import 'package:mega/services/callback_types.dart';

import '../details/feature_detail_add_screen.dart';

class AddFeatureScreen extends StatefulWidget {
  final CommunityModel community;

  const AddFeatureScreen({Key key, this.community}) : super(key: key);

  @override
  _AddFeatureScreenState createState()=> _AddFeatureScreenState();
}

class _AddFeatureScreenState extends State<AddFeatureScreen>{
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
    return Scaffold(
      appBar: MyAppBars.myAppBar2(),
      body: Padding(
        child: Column(
          children: <Widget>[
            BigText(text:'Add features'),
            Padding(
              child: SearchInput(
                onChangeCallback: onSearch,
              ),
              padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
            ),
            FeatureGrid(
              searchVal: searchVal,
              community: widget.community,
              tapCardCallback: tapCardCallback,
            ),
          ],
        ),
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
      ),
    );
  }
}

class FeatureGrid extends StatefulWidget{

  final String searchVal;

  final CommunityModel community;

  final TapCardCallback tapCardCallback;

  FeatureGrid({Key key, this.searchVal, this.community, this.tapCardCallback}) : super(key: key);

  @override
  _FeatureGridState createState() => _FeatureGridState();
}

class _FeatureGridState extends State<FeatureGrid>{
  Future<List<FeatureModel>> features;

  @override
  Widget build(BuildContext context) {
    if (widget.searchVal == null) features = FeatureAPI.getAllFeatures(context, widget.community.type, widget.community.id);

    return FutureBuilder<List<FeatureModel>>(
      future: features,
      builder: (BuildContext context, AsyncSnapshot<List<FeatureModel>> snapshot) {
        Widget _widget;
        if(snapshot.hasData){
          _widget = MyCardGrid(
            list: widget.searchVal == null ?
            snapshot.data : snapshot.data.where((element) => element.name.toLowerCase().contains(widget.searchVal)).toList(),
            emptyText: 'No unused features to add',
            emptySubtext: 'you can only add features you haven\'t used',
            tapCardCallback: widget.tapCardCallback,
          );
        } else if (snapshot.hasError){
          _widget = ErrorTextWithIcon(text: 'Something went wrong', subtext: 'try again',);
        } else {
          _widget = CircularProgressIndicator();
        }
        return _widget;
      },
    );
  }
}