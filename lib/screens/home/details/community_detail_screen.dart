import 'package:flutter/material.dart';
import 'package:mega/components/bars/my_app_bars.dart';
import 'package:mega/components/buttons/my_button.dart';
import 'package:mega/components/cards/my_card.dart';
import 'package:mega/components/texts/big_text.dart';
import 'package:mega/models/community_model.dart';
import 'package:mega/screens/home/home_screen.dart';
import 'package:mega/screens/home/manage_feature_screen.dart';
import 'package:mega/services/api/community_api.dart';

/// Screen where community details are presented
class CommunityDetailScreen extends StatefulWidget{
  /// The community
  final CommunityModel community;

  const CommunityDetailScreen({Key key, @required this.community}) : super(key: key);

  @override
  _CommunityDetailScreenState createState()=>_CommunityDetailScreenState();
}

class _CommunityDetailScreenState extends State<CommunityDetailScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBars.myAppBar2(),
      body: Padding(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              BigText(text:widget.community.name + ' details'),
              Align(
                child: Row(
                  children: <Widget>[
                    MyCard(imageUrl: widget.community.pictureUrl, texts: [],),
                    Padding(
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Column(
                        children: <Widget>[
                          Text('type: ' + widget.community.type),
                          SelectableText('key: ' + widget.community.key),
                          if(widget.community.isAdmin) MyButton(
                            buttonText: 'manage features',
                            onPressCallback: (){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context)=>ManageFeatureScreen(community: widget.community,)
                              ));
                            },
                          ),
                          if(!widget.community.isAdmin)MyButton(
                            buttonText: 'leave',
                            onPressCallback: () async {
                              await CommunityAPI.leaveCommunities(context, widget.community.id.toString());
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context)=>HomeScreen()
                              ));
                            },
                          )
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