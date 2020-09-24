import 'package:flutter/material.dart';
import 'package:mega/components/bars/my_app_bars.dart';
import 'package:mega/components/cards/my_card_grid.dart';
import 'package:mega/components/inputs/search_input.dart';
import 'package:mega/components/texts/big_text.dart';
import 'package:mega/components/texts/error_text_with_icon.dart';
import 'package:mega/models/community_model.dart';
import 'package:mega/models/state_models/current_community_state_model.dart';
import 'package:mega/models/feature_model.dart';
import 'package:mega/screens/home/add/add_feature_screen.dart';
import 'package:mega/screens/home/details/community_detail_screen.dart';
import 'package:mega/screens/home/details/feature_detail_screen.dart';
import 'package:mega/services/api/feature_api.dart';
import 'package:provider/provider.dart';

/// The community screen
///
/// Displays the list of features
class CommunityScreen extends StatefulWidget{
  /// The community
  final CommunityModel community;

  const CommunityScreen({Key key, @required this.community}) : super(key: key);

  @override
  _CommunityScreenState createState()=>_CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen>{
  /// The community features
  Future<List<FeatureModel>> features;

  /// Search bar value
  String searchVal;

  /// Filter feature list on search
  void onSearch(String val){
    setState(() {
      searchVal = val;
    });
  }

  /// Callback when feature card tapped
  ///
  /// Goes to feature detail screen when the feature's card is tapped
  void tapCardCallback(BuildContext context, dynamic item){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FeatureDetailScreen(feature: item, community: this.widget.community)),
    );
  }

//  /// refresh widget
//  Future<void> forceRefresh() async{
//    setState((){});
//  }

  @override
  Widget build(BuildContext context) {
    // set the current community
    Provider.of<CurrentCommunityStateModel>(context, listen: false).setCurrentCommunity(widget.community);

    // get the list of features
    if (searchVal == null) features = FeatureAPI.getFeatures(context, widget.community.id);

    return Scaffold(
      appBar: MyAppBars.myAppBar4(context, logoUrl: this.widget.community.pictureUrl),
      body: Padding(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: BigText(text:this.widget.community.name),
                ),
                IconButton(
                  icon: Icon(Icons.settings),
                  iconSize: 40,
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CommunityDetailScreen(community: this.widget.community)),
                    );
                  },
                )
              ],
            ),
            Align(
              child: Text(
                'You are ' + (this.widget.community.isAdmin ? 'admin' : 'member'),
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
                  print(snapshot.error);
                  _widget = ErrorTextWithIcon(text: 'Could not retrieve features', subtext: 'try again',);
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