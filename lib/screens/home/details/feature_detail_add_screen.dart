import 'package:flutter/material.dart';
import 'package:mega/components/bars/my_app_bars.dart';
import 'package:mega/components/buttons/my_button.dart';
import 'package:mega/components/cards/my_card.dart';
import 'package:mega/components/texts/big_text.dart';
import 'package:mega/models/community_model.dart';
import 'package:mega/models/feature_model.dart';
import 'package:mega/screens/home/community_screen.dart';
import 'package:mega/services/api/feature_api.dart';

/// Screen where community admin adds feature to the community
class FeatureDetailAddScreen extends StatelessWidget{
  /// The feature
  final FeatureModel feature;

  /// The community
  final CommunityModel community;

  const FeatureDetailAddScreen({Key key, @required this.feature, @required this.community}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBars.myAppBar2(),
        body: Padding(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                BigText(text:'Add ' + feature.name + ' feature to the community'),
                Align(
                  child: Row(
                    children: <Widget>[
                      MyCard(imageUrl: feature.pictureUrl, texts: [],),
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: Column(
                          children: <Widget>[
                            MyButton(
                              buttonText: 'add to community',
                              onPressCallback: () async {
                                // add feature to community by calling API
                                bool _res = await FeatureAPI.addFeatureToCommunity(context, feature.id, community.id);
                                if(_res) Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CommunityScreen(community: community)
                                  ),
                                );
                              }),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ),
                    ],
                  ),
                  alignment: Alignment.bottomLeft,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: Text(feature.description),
                )
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        ),
    );
  }
}