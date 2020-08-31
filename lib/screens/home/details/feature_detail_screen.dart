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

class FeatureDetailScreen extends StatefulWidget{
  final FeatureModel feature;
  final CommunityModel community;

  FeatureDetailScreen({Key key, this.feature, this.community}) : super(key: key);

  final Map<String, dynamic> json = {
    'admin': {
      'home': {
        'metadata': {
          'show_back_button': 'false'
        },
        'components': [
//          {
//            'grid': {
//              'action': {
//                'action_type': 'get',
//                'tag': 'menu',
//                'add_page': {
//                  'new_page': 'add_menu'
//                }
//              },
//              'title': {
//                'value': 'mega\$action\$value.item_name'
//              },
//              'subtitle': {
//                'value': 'mega\$action\$value.item_price'
//              },
//              'image': {
//                'value': 'mega\$action\$value.item_picture'
//              }
//            }
//          },
          {
            'grid': {
              'action': {
                'action_type': 'get',
                'tag': 'menu',
                'add_page': {
                  'new_page': 'add_menu'
                },
                'search': {
                  'field': 'item_name'
                }
              },
              'title': {
                'value': 'mega\$action\$value.item_name',
                'prefix': 'item: '
              },
              'subtitle': {
                'value': 'mega\$action\$value.item_price',
                'prefix': 'price: \$'
              },
              'image': {
                'value': 'mega\$action\$value.item_picture'
              },
              'empty_text': {
                'value': 'No items'
              },
              'empty_subtext': {
                'value': 'add below'
              },
              'error_text': {
                'value': 'Cannot retrieve communities'
              },
              'error_subtext': {
                'value': 'Try again'
              },
            }
          },
        ]
      },
      'add_menu': {
        'components': [
          {
            'form': {
              'action': {
                'action_type': 'save',
                'multipart': [
                  {
                    'field': 'item_picture'
                  }
                ],
                'method': 'post',
                'access': 'community',
                'tag': 'menu'
              },
              'body': [
                {
                  'stuffing': {
                    'height': '20',
                  }
                },
                {
                  'input': {
                    'type': 'text',
                    'name': 'item_name',
                    'hint': 'item name *',
                    'validators': {
                      'required':'',
                    }
                  }
                },
                {
                  'stuffing': {
                    'height': '20',
                  }
                },
                {
                  'input': {
                    'type': 'text',
                    'name': 'item_price',
                    'hint': 'item price *',
                    'validators': {
                      'required':'',
                      'number': ''
                    }
                  }
                },
                {
                  'stuffing': {
                    'height': '20',
                  }
                },
                {
                  'input': {
                    'type': 'file',
                    'name': 'item_picture',
                    'hint': 'item picture *',
                    'validators': {
                      'required':'',
                      'max_file_size': 2.0
                    }
                  }
                },
                {
                  'submit_button': {
                    'value': 'submit',
                    'action': {
                      'action_type': 'change_page',
                      'new_page': 'home', // specify name of new page
                    }
                  }
                },
              ]
            }
          },
        ]
      },
    },
    'member': {
      'home': {
        'components': [
          {
            'list': {
              'action': {
                'action_type': 'get',
                'tag': 'menu',
              },
              'title': {
                'value': 'mega\$action\$value.item_name'
              },
              'subtitle': {
                'value': 'mega\$action\$value.item_price',
                'prefix': 'price: \$'
              },
//              'image': {
//                'value': 'mega\$action\$value.item_picture'
//              },
              'empty_text': {
                'value': 'No items'
              },
            }
          },
        ]
      }
    }
  };

  @override
  _FeatureDetailScreenState createState()=> _FeatureDetailScreenState();
}

class _FeatureDetailScreenState extends State<FeatureDetailScreen>{

  final String _firstFeatureScreen = 'home';

  ListQueue<String> screenStack = ListQueue<String>();

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
        appBar: MyAppBars.myAppBar5(context, onPop: ()=>setState(()=>{screenStack.removeLast()}), isFirstScreen: isFirstScreen),
        body: Padding(
          child: Column(
            children: <Widget>[
              BigText(this.widget.feature.name),
              Expanded(
                child: Column(
                  children: widgetList
                ),
              )
            ],
          ),
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        )
    );
  }
}