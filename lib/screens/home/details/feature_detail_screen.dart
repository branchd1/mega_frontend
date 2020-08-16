import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:mega/components/bars/my_app_bars.dart';
import 'package:mega/components/buttons/my_button.dart';
import 'package:mega/components/buttons/my_submit_button.dart';
import 'package:mega/components/inputs/dropdown_input.dart';
import 'package:mega/components/inputs/my_email_input.dart';
import 'package:mega/components/inputs/my_password_input.dart';
import 'package:mega/components/inputs/my_text_input.dart';
import 'package:mega/components/texts/big_text.dart';
import 'package:mega/components/texts/error_text.dart';
import 'package:mega/models/community_model.dart';
import 'package:mega/models/feature_model.dart';
import 'package:mega/models/feature_screen_back_button_model.dart';
import 'package:mega/services/api/base_api.dart';
import 'package:mega/services/api/feature_dev_api.dart';
import 'package:provider/provider.dart';

const Map<String, dynamic> configurationMap = {
  'text': CreatableText.createText,
  'button': CreatableButton.createButton,
  'submit_button': CreatableButton.createButton,
  'form': CreatableForm.createForm,
  'input': CreatableInput.createInput,
  'stuffing': CreatableStuffing.createStuffing,
};

final Map<String, Widget> idToWidgetMap = {};

class CreatableStuffing extends StatelessWidget{
  final Map data;

  const CreatableStuffing({Key key, this.data}) : super(key: key);

  static Widget createStuffing(Map _data){
    return CreatableStuffing(data: _data);
  }

  @override
  Widget build(BuildContext context) {
    assert(data['height'] != null);

    final double _height = double.tryParse(data['height']) ;

    return Container(
      height: _height != null ? _height : 10,
    );
  }
}

class CreatableText extends StatelessWidget{
  final Map data;

  const CreatableText({Key key, this.data}) : super(key: key);

  static Widget createText(Map _data){
    return CreatableText(data: _data);
  }

  @override
  Widget build(BuildContext context) {
//    if(data['id'] != null) assert((data['id']).length > 5); // move to external validator
    assert(data['value'] != null);

    Widget _text = Text(
      data['value']
    );

//    if(data['id'] != null) widgetMap.addAll({data['id']: _text});
    return _text;
  }
}

class CreatableInput extends StatelessWidget{
  final List<String> inputTypes = ['email', 'text'];
  final Map data;
  final TextEditingController controller;

  CreatableInput({Key key, this.data, this.controller}) : super(key: key);

  static Widget createInput(Map _data, {TextEditingController controller}){
    return CreatableInput(data: _data, controller: controller,);
  }

  @override
  Widget build(BuildContext context) {
    assert(data['type'] != null);
    assert(inputTypes.contains(data['type']));

    if(data['type'] == 'email') return MyEmailInput(controller: controller,);

//    not yet implemented
//    if(data['type'] == 'text') return MyTextInput();
//    if(data['type'] == 'password') return MyPasswordInput();
//    if(data['type'] == 'dropdown') return DropdownInput();

    return Container();
  }
}

class CreatableForm extends StatefulWidget{
  final Map data;

  const CreatableForm({Key key, this.data}) : super(key: key);

  static Widget createForm(Map _data) => CreatableForm(data: _data);

  _CreatableFormState createState() => _CreatableFormState();
}

class _CreatableFormState extends State<CreatableForm>{

  Map<TextEditingController, String> _controllersMap = Map<TextEditingController, String>();
  final _formKey = GlobalKey<FormState>();

  void submit() async {
    if (_formKey.currentState.validate()){
      // get form action map
      Map<String, dynamic> _formActionMap = widget.data['action'];

      // create map from data
      Map<String, String> formValuesMap = Map<String, String>.from(_controllersMap.map((key, value) => MapEntry(value, key.text)));

      // calling external api
      if (_formActionMap['action_type'] == 'external_api'){
        assert(_formActionMap['method']!=null);

        // send data to api and do something with it
        if(_formActionMap['method'] == 'get') {
          // send map for storage in server
          FeatureDevAPI.getExternal(context,
            _formActionMap['url'],
            _formActionMap['endpoint'],
            params: formValuesMap
          );
          // incomplete
        } else if (_formActionMap['method'] == 'post'){
          // send map for storage in server
          FeatureDevAPI.postExternal(context,
            _formActionMap['url'],
            _formActionMap['endpoint'], data: formValuesMap
          );
          // incomplete
        } else {
          throw ('action method must be get or post');
        }
      }
      // saving to data store
      else if (_formActionMap['action_type'] == 'save'){
        // send data to api and do something with it
        if(_formActionMap['method'] == 'get') {
          // send map for storage in server
          FeatureDevAPI.getToDataStore(context, params: formValuesMap);
          // incomplete
        } else if (_formActionMap['method'] == 'post'){
          // send map for storage in server
          FeatureDevAPI.saveToDataStore(context, data: formValuesMap);
          // incomplete
        } else {
          throw ('action method must be get or post');
        }
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    assert(widget.data['body'] != null);
    assert(widget.data['action'] != null);

    List<Map<String, dynamic>> _formBody = widget.data['body'];

    // this is repeated somewhere else, put in one method?
    List<Widget> list = _formBody.map<Widget>((component){
      final String _componentName = component.keys.toList()[0];
      try{
        if(_componentName=='submit_button') {
          return configurationMap[_componentName](component[_componentName], submitCallback: submit);
        } else if (_componentName=='input'){
          // store the controller
          TextEditingController inputController = TextEditingController();
          _controllersMap.putIfAbsent(inputController, () => component[_componentName]['name']);

          return configurationMap[_componentName](component[_componentName], controller: inputController);
        }
        return null;
      }
      on NoSuchMethodError{
        String err = 'A component (' + _componentName + ') used does not exist';
        print(err);
        return ErrorText(err);
      }
    }).toList();

    return Form(
      key: _formKey,
      child: Column(
        children: list,
      ),
    );
  }
}

class CreatableButton extends StatelessWidget{
  static const String changePage='change_page', getData='get_data';

  final Map data;
  final FormSubmitCallback submitCallback;

  const CreatableButton({Key key, this.data, this.submitCallback}) : super(key: key);

  void buttonAction(Map<String, dynamic> action){
    String actionType = action['action_type'];

    if (actionType == changePage){
      assert(action.containsKey('new_page')); // delegate to a function that checks components structured correctly
      action['new_page']();
    }
  }

  static Widget createButton(Map _data, {FormSubmitCallback submitCallback}) => CreatableButton(data: _data, submitCallback: submitCallback);

  @override
  Widget build(BuildContext context) {
    assert(data['value'] != null);

    if(submitCallback != null) {
      return Align(
        alignment: Alignment.bottomRight,
        child: MySubmitButton(
          buttonText: data['value'],
          submitCallback: () {
            submitCallback();
            if (data['action'] != null) buttonAction(data['action']);
          }
        )
      );
    } else {
      return MyButton(
        buttonText: data['value'],
        onPressCallback: () {
          if (data['action'] != null) buttonAction(data['action']);
        }
      );
    }
  }
}

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
          {
            'text': {
              'value': 'hello',
            },
          },
          {
            'button': {
              'value': 'hey',
              'action': {
                'action_type': 'change_page',
                'new_page': 'second',
                'page_params': {
                  'name': 'from_second', // param "name" value can be gotten from element of id 1
                }
              }
            }
          }
        ]
      },
      'second': {
        'components': [
          {
            'text': {
              'value': 'second',
            },
          },
          {
            'button': {
              'value': 'second_button',
              'action': {
                'action_type': 'change_page',
                'new_page': 'third', // specify name of new page
              }
            }
          }
        ]
      },
      'third': {
        'components': [
          {
            'form': {
              'action': {
                'action_type': 'save',
                'method': 'get',
              },
              'body': [
                {
                  'input': {
                    'type': 'email',
                    'name': 'email',
                  },
                },
                {
                  'submit_button': {
                    'value': 'submit',
                  }
                }
              ]
            }
          },
          {
            'form': {
              'action': {
                'action_type': 'save',
                'method': 'get',
              },
              'body': [
                {
                  'input': {
                    'type': 'email',
                    'name': 'email',
                  }
                },
                {
                  'submit_button': {
                    'value': 'submit',
                  }
                }
              ]
            }
          }
        ]
      },
    },
    'member': {
      'home': {
        'components': [
          {
            'text': {
              'value': 'hi'
            }
          }
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
      value = Map<String, dynamic>.from(value.map(replaceMapValues));
    } else if(value is List){
      // create new list from
      List<dynamic> newList = value.map((Map<String, dynamic> map)=>
        Map<String, dynamic>.from(map.map(replaceMapValues))
      ).toList();

      // update value
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
      if (!isFirstScreen && _screenMetadata['show_back_button'] == 'false') Provider.of<FeatureScreenBackButtonModel>(context).setShowBackButton(false);
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