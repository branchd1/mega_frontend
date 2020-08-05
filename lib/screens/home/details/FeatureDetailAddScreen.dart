import 'package:flutter/material.dart';
import 'package:mega/components/bars/MyAppBars.dart';
import 'package:mega/components/bars/MyBottomNav.dart';
import 'package:mega/components/buttons/MyButton.dart';
import 'package:mega/components/cards/MyCard.dart';
import 'package:mega/components/texts/BigText.dart';
import 'package:mega/components/texts/MainText.dart';
import 'package:mega/models/FeatureModel.dart';
import 'package:mega/services/api/FeatureAPI.dart';

class FeatureDetailAddScreen extends StatelessWidget{
  final FeatureModel feature;

  const FeatureDetailAddScreen({Key key, this.feature}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBars.myAppBar3(),
        body: Padding(
          child: Column(
            children: <Widget>[
              BigText(feature.name + ' feature details'),
              Align(
                child: Row(
                  children: <Widget>[
                    MyCard(imageUrl: feature.picture),
                    Padding(
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Column(
                        children: <Widget>[
                          MainText(feature.name),
                          Text(feature.communityType),
                          MyButton(
                            buttonText: 'add to community',
                            onPressCallback: () async {
                              bool _res = await FeatureAPI.addFeatureToCommunity(context, feature.id, 1);
                              if(_res) Navigator.pop(context);
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
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        ),
        bottomNavigationBar: MyBottomNav(
            bottomNavActivePage: BottomNavActivePage.home
        )
    );
  }
}