import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:mega/components/bars/my_app_bars.dart';
import 'package:mega/components/texts/big_text.dart';
import 'package:mega/components/texts/error_text.dart';
import 'package:mega/models/community_model.dart';
import 'package:mega/models/state_models/current_feature_state_model.dart';
import 'package:mega/models/feature_model.dart';
import 'package:mega/models/state_models/feature_screen_back_button_state_model.dart';
import 'package:mega/screens/home/details/dont_forget_to_move.dart';
import 'package:mega/services/constants.dart';
import 'package:provider/provider.dart';

class FeatureDetailScreen extends StatefulWidget{
  final FeatureModel feature;
  final CommunityModel community;

  FeatureDetailScreen({Key key, this.feature, this.community}) : super(key: key);

  final Map<String, dynamic> json = jsonDataDelete;

  @override
  _FeatureDetailScreenState createState()=> _FeatureDetailScreenState();
}

class _FeatureDetailScreenState extends State<FeatureDetailScreen>{

  final String _firstFeatureScreen = 'home';

  ListQueue<String> screenStack = ListQueue<String>();

  MapEntry<String, dynamic> replaceMapValues(String key, dynamic value){
    // recursively replace map values
    if(value is Map){
      value = Map<String, dynamic>.from(value.map(replaceMapValues));
    } else if(value is List){
      // create new list from old one. Replace inner maps
      List<dynamic> newList = value.map((Map<String, dynamic> map)=>
        Map<String, dynamic>.from(map.map(replaceMapValues))
      ).toList();

      // update value to new list
      value = List<Map<String, dynamic>>.from(newList);
    }

    // do replacement
    if(key == 'new_page' && value is String){
      return MapEntry(key, ()=>setState(()=>{screenStack.add(value)})); // function passes change screen callback to components
    } else {
      return MapEntry(key, value);
    }
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<CurrentFeatureStateModel>(context, listen: false).setCurrentFeature(widget.feature);

    // get admin or member data
    assert(widget.json != null);
    assert(widget.json.containsKey('admin') || widget.json.containsKey('member'));
    final Map<String, dynamic> _newJson = widget.community.isAdmin ? widget.json['admin'] : widget.json['member'];

    // replace special values and data in configuration data
    assert(_newJson != null);
    assert(_newJson.containsKey('home'));
    assert(_newJson['home'].keys.length > 0);
    final Map<String, dynamic> _replacedJson = _newJson.map(replaceMapValues);

    // if stack is empty, add the first screen
    if (screenStack.isEmpty) screenStack.add(_firstFeatureScreen);

    // load the current screen data
    Map<String, dynamic> _screenData = _replacedJson[screenStack.last];

    // check if its first screen
    final isFirstScreen = screenStack.length == 1;

    // configure screen with metadata
    Map<String, dynamic> _screenMetadata = _screenData['metadata'];
    if(_screenMetadata != null) {
      // set show back button
      if (!isFirstScreen && _screenMetadata['show_back_button'] == 'false') Provider.of<FeatureScreenBackButtonStateModel>(context).setShowBackButton(false);
    }

    // create list of widgets from configuration data
    List<Map<String, dynamic>> _screenComponents = _screenData['components'];
    List<Widget> widgetList = _screenComponents.map<Widget>((component){
      final String _componentName = component.keys.toList()[0];
      try{
        return configurationMap[_componentName](component[_componentName]);
      } on NoSuchMethodError{
        // inform user of error
        String err = 'A component (' + _componentName + ') used does not exist';
        print(err);
        return ErrorText(err);
      }
    }).toList();

    return Scaffold(
        appBar: MyAppBars.myAppBar5(context, onPop: ()=>setState(()=>{screenStack.removeLast()}), isFirstScreen: isFirstScreen),
        body: Padding(
          child: Column(
            children: <Widget>[
              BigText(this.widget.feature.name),
              Column(
                  children: widgetList
              )
            ],
          ),
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        )
    );
  }
}