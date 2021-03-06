import 'package:flutter/material.dart';
import 'package:mega/components/bars/my_app_bars.dart';
import 'package:mega/components/buttons/my_button.dart';
import 'package:mega/forms/create_community_form.dart';
import 'package:mega/forms/join_community_form.dart';
import 'package:mega/components/texts/big_text.dart';
import 'package:mega/services/type_defs.dart';

/// Screen where user creates / joins a community
class AddCommunityScreen extends StatefulWidget{
  @override
  _AddCommunityScreenState createState() => _AddCommunityScreenState();
}

class _AddCommunityScreenState extends State<AddCommunityScreen>{

  /// The method to add community
  ///
  /// The default method is to join a community
  AddCommunityMethods addCommunityMethod = AddCommunityMethods.join;

  /// Change between joining and creating a community
  /// Decides the form to show
  void changeScreen(){
    setState(() {
      addCommunityMethod = addCommunityMethod == AddCommunityMethods.join ?
      AddCommunityMethods.create : AddCommunityMethods.join;
    });
  }

  @override
  Widget build(BuildContext context) {
    return(
      Scaffold(
        appBar: MyAppBars.myAppBar1(),
        body: Padding(
          child: Column(
            children: <Widget>[
              Image.asset('assets/img/logo/logo.png'),
              addCommunityMethod == AddCommunityMethods.join ? Column(
                children: <Widget>[
                  BigText(text:'Join Community'),
                  Padding(
                    child: JoinCommunityForm(),
                    padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  ),
                  Align(
                    child: MyButton(buttonText: 'create a community', onPressCallback: changeScreen,),
                    alignment: Alignment.bottomLeft,
                  )
                ],
              ) : Column(
                children: <Widget>[
                  BigText(text:'Create Community'),
                  Padding(
                    child: CreateCommunityForm(),
                    padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  ),
                  Align(
                    child: MyButton(buttonText: 'join a community', onPressCallback: changeScreen,),
                    alignment: Alignment.bottomLeft,
                  )
                ],
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        ),
      )
    );
  }
}