import 'package:flutter/material.dart';
import 'package:mega/components/bars/MyAppBars.dart';
import 'package:mega/components/bars/MyBottomNav.dart';
import 'package:mega/components/buttons/MyButton.dart';
import 'package:mega/components/cards/MyCard.dart';
import 'package:mega/components/texts/BigText.dart';
import 'package:mega/components/texts/MainText.dart';
import 'package:mega/models/FeatureModel.dart';

class FeatureDetailAddScreen extends StatelessWidget{
  final FeatureModel feature;

  const FeatureDetailAddScreen({Key key, this.feature}) : super(key: key);

  void addFeatureToCommunity(){
    // do something
  }

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
                    Column(
                      children: <Widget>[
                        MainText(feature.name),
                        Text(feature.communityType),
                        MyButton(buttonText: 'add to community', onPressCallback: addFeatureToCommunity),
                      ],
                    )
                  ],
                ),
                alignment: Alignment.bottomLeft,
              )
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