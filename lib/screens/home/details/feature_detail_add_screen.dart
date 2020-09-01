import 'package:flutter/material.dart';
import 'package:mega/components/bars/my_app_bars.dart';
import 'package:mega/components/buttons/my_button.dart';
import 'package:mega/components/cards/my_card.dart';
import 'package:mega/components/texts/big_text.dart';
import 'package:mega/components/texts/main_text.dart';
import 'package:mega/models/community_model.dart';
import 'package:mega/models/feature_model.dart';
import 'package:mega/screens/home/community_screen.dart';
import 'package:mega/services/api/feature_api.dart';

class FeatureDetailAddScreen extends StatelessWidget{
  final FeatureModel feature;

  final CommunityModel community;

  const FeatureDetailAddScreen({Key key, this.feature, this.community}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBars.myAppBar3(),
        body: Padding(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                BigText(feature.name + ' feature details'),
                Align(
                  child: Row(
                    children: <Widget>[
                      MyCard(imageUrl: feature.picture, texts: [],),
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: Column(
                          children: <Widget>[
                            MainText(feature.name),
                            MyButton(
                              buttonText: 'add to community',
                              onPressCallback: () async {
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