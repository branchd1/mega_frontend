import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:mega/components/bars/my_app_bars.dart';
import 'package:mega/components/texts/big_text.dart';
import 'package:mega/components/texts/error_text_plain.dart';
import 'package:mega/models/community_model.dart';
import 'package:mega/models/state_models/current_feature_state_model.dart';
import 'package:mega/models/feature_model.dart';
import 'package:mega/services/constants.dart';
import 'package:provider/provider.dart';

/// Feature detail screen
///
/// Displays the widget using the features code / configuration gotten from
/// the database
class FeatureDetailScreen extends StatefulWidget{
  /// The feature
  final FeatureModel feature;

  /// The current community
  final CommunityModel community;

  FeatureDetailScreen({Key key, this.feature, this.community}) : super(key: key);

  @override
  _FeatureDetailScreenState createState()=> _FeatureDetailScreenState();
}

class _FeatureDetailScreenState extends State<FeatureDetailScreen>{

  /// The default first screen
  final String _firstFeatureScreen = 'home';

  /// The screen stack to maintain screen history
  ListQueue<String> screenStack = ListQueue<String>();

  /// Replaces special characters in the features configuration / code data
  /// Checks if the configuration data is well formed
  MapEntry<String, dynamic> replaceMapValues(String key, dynamic value){
    // recursively replace map values
    if(value is Map){
      // throw error for empty maps
      if((value as Map).isEmpty) throw ('Configuration data not well formed. Remove empty maps.');

      value = Map<String, dynamic>.from(value.map(replaceMapValues));
    } else if(value is List){
      // throw error for empty lists
      if((value as List).isEmpty) throw ('Configuration data not well formed. Remove empty lists.');

      // create new list from old one. Replace inner maps
      List<dynamic> newList = value.map((dynamic map){
        return Map<String, dynamic>.from(map.map(replaceMapValues));
      }).toList();

      // update value to new list
      value = List<Map<String, dynamic>>.from(newList);
    }

    // do replacement
    if(key == 'new_page' && value is String){
      // replace specified string value with the relevant callback function
      // function passes change screen callback to components
      return MapEntry(key, ()=>setState(()=>{screenStack.add(value)}));
    } else {
      return MapEntry(key, value);
    }
  }

  @override
  Widget build(BuildContext context) {
    // set feature as the current feature globally
    Provider.of<CurrentFeatureStateModel>(context, listen: false).setCurrentFeature(widget.feature);

    // get admin or member data
    assert(widget.feature.payload != null);
    assert(widget.feature.payload.containsKey('admin') || widget.feature.payload.containsKey('member'));
    final Map<String, dynamic> _newJson = widget.community.isAdmin ? widget.feature.payload['admin'] : widget.feature.payload['member'];

    // replace special values and data in configuration data
    assert(_newJson != null);
    assert(_newJson.containsKey('home'));
    assert(_newJson['home'].keys.length > 0);
    final Map<String, dynamic> _replacedJson = _newJson.map(replaceMapValues);

    // if stack is empty, add the first screen
    if (screenStack.isEmpty) screenStack.add(_firstFeatureScreen);

    // load the current screen data
    Map<String, dynamic> _screenData = _replacedJson[screenStack.last];

    if(_screenData == null){
      throw 'A screen that does not exist was loaded';
    }

    // check if its first screen
    final isFirstScreen = screenStack.length == 1;

//    // configure screen with metadata
//    Map<String, dynamic> _screenMetadata = _screenData.containsKey('metadata') ? _screenData['metadata'] : null;
//    if(_screenMetadata != null) {
//      // set show back button
//      if(!isFirstScreen && _screenMetadata['show_back_button'] == 'false') {
//        Provider.of<FeatureScreenBackButtonStateModel>(context).setShowBackButton(false);
//      } else {
//        Provider.of<FeatureScreenBackButtonStateModel>(context).setShowBackButton(true);
//      }
//    }

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
        return ErrorTextPlain(err);
      }
    }).toList();

    return Scaffold(
      appBar: MyAppBars.myAppBar3(context, onPop: ()=>setState((){
        screenStack.removeWhere((element) => element == screenStack.last);
      }), isFirstScreen: isFirstScreen),
      body: Padding(
        child: Column(
          children: <Widget>[
            BigText(text:this.widget.feature.name),
            Expanded(
              child: Column(
                children: widgetList,
              ),
            ),
          ],
        ),
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
      )
    );
  }
}