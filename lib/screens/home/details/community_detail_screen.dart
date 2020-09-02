import 'package:flutter/material.dart';
import 'package:mega/components/bars/my_app_bars.dart';
import 'package:mega/components/cards/my_card.dart';
import 'package:mega/components/cards/my_card_grid.dart';
import 'package:mega/components/inputs/search_input.dart';
import 'package:mega/components/texts/big_text.dart';
import 'package:mega/components/texts/error_text_with_icon.dart';
import 'package:mega/components/texts/main_text.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBars.myAppBar3(),
      body: Padding(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              BigText(widget.community.name + ' details'),
              Align(
                child: Row(
                  children: <Widget>[
                    MyCard(imageUrl: widget.community.picture, texts: [],),
                    Padding(
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Column(
                        children: <Widget>[
                          Text('type: ' + widget.community.type),
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
                child: Text(widget.community.description),
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