import 'package:flutter/material.dart';
import 'package:mega/components/bars/my_app_bars.dart';
import 'package:mega/components/buttons/my_button.dart';
import 'package:mega/components/forms/create_community_form.dart';
import 'package:mega/components/forms/join_community_form.dart';
import 'package:mega/components/texts/big_text.dart';

class AddCommunityScreen extends StatefulWidget{
  @override
  _AddCommunityScreenState createState() => _AddCommunityScreenState();
}

enum AddCommunityMethods {
  join,
  create
}

class _AddCommunityScreenState extends State<AddCommunityScreen>{

  AddCommunityMethods addCommunityMethod = AddCommunityMethods.join;

  void changeScreen(){
    setState(() {
      addCommunityMethod = addCommunityMethod == AddCommunityMethods.join ? AddCommunityMethods.create : AddCommunityMethods.join;
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
                  BigText('Join Community'),
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
                  BigText('Create Community'),
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