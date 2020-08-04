import 'package:flutter/material.dart';
import 'package:mega/components/bars/MyAppBars.dart';
import 'package:mega/components/buttons/MyButton.dart';
import 'package:mega/components/forms/CreateCommunityForm.dart';
import 'package:mega/components/forms/JoinCommunityForm.dart';
import 'package:mega/components/texts/BigText.dart';

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
                    child: MyButton(buttonText: 'join a community', onPressCallback: changeScreen,),
                    alignment: Alignment.bottomRight,
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
                    alignment: Alignment.bottomRight,
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