import 'package:flutter/material.dart';
import 'package:mega/components/bars/my_app_bars.dart';
import 'package:mega/components/bars/my_bottom_nav.dart';
import 'package:mega/components/cards/my_card_grid.dart';
import 'package:mega/components/inputs/search_input.dart';
import 'package:mega/components/texts/big_text.dart';
import 'package:mega/models/community_model.dart';
import 'package:mega/models/state_models/current_community_state_model.dart';
import 'package:mega/models/feature_model.dart';
import 'package:mega/screens/home/add/add_feature_screen.dart';
import 'package:mega/screens/home/details/feature_detail_screen.dart';
import 'package:mega/services/api/feature_api.dart';
import 'package:provider/provider.dart';

class CommunityDetailScreen extends StatefulWidget{
  final CommunityModel community;

  const CommunityDetailScreen({Key key, this.community}) : super(key: key);

  @override
  _CommunityDetailScreenState createState()=>_CommunityDetailScreenState();
}

class _CommunityDetailScreenState extends State<CommunityDetailScreen>{
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
      MaterialPageRoute(builder: (context) => FeatureDetailScreen(feature: item, community: this.widget.community)),
    );
  }

  Future<void> forceRefresh() async{
    setState((){});
  }

  @override
  Widget build(BuildContext context) {
    // set the current community
    Provider.of<CurrentCommunityStateModel>(context, listen: false).setCurrentCommunity(widget.community);

    if (searchVal == null) features = FeatureAPI.getFeatures(context, widget.community.id);
    return Scaffold(
      appBar: MyAppBars.myAppBar6(context, logoUrl: this.widget.community.picture),
      body: Padding(
        child: Column(
          children: <Widget>[
            BigText(this.widget.community.name),
            Align(
              child: Text(
                this.widget.community.isAdmin ? 'admin' : 'member',
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
                  _widget = Expanded(
                    child: MyCardGrid(
                      list: searchVal == null ?
                      snapshot.data : snapshot.data.where((element) => element.name.toLowerCase().contains(searchVal)).toList(),
                      addButtonCallback: this.widget.community.isAdmin ? (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddFeatureScreen(
                              community: this.widget.community,
                            )
                          ),
                        );
                      } : null,
                      emptyText: 'No features',
                      emptySubtext: 'add below',
                      tapCardCallback: tapCardCallback,
                    ),
                  );
                } else if (snapshot.hasError){
                  _widget = Text('Error');
                } else {
                  _widget = CircularProgressIndicator();
                }
                return _widget;
//                return RefreshIndicator(
//                  child: _widget,
//                  onRefresh: forceRefresh,
//                );
              },
            ),
          ],
        ),
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
      ),
    );
  }
}