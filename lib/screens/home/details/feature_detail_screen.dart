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
import 'package:mega/models/feature_model.dart';
import 'package:mega/models/feature_screen_back_button_model.dart';
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

  CreatableInput({Key key, this.data}) : super(key: key);

  static Widget createInput(Map _data){
    return CreatableInput(data: _data);
  }

  @override
  Widget build(BuildContext context) {
    assert(data['type'] != null);
    assert(inputTypes.contains(data['type']));

    if(data['type'] == 'email') return MyEmailInput();

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

  List<TextEditingController> controllers;
  final _formKey = GlobalKey<FormState>();

  void submit() async {
    if (_formKey.currentState.validate()){

    }
  }

  @override
  Widget build(BuildContext context) {
    assert(widget.data['body'] != null);
    assert(widget.data['action'] != null);

    Map<String, dynamic> _formBody = widget.data['body'];

    // this is repeated somewhere else, put in one method?
    List<Widget> list = _formBody.keys.map<Widget>((i){
      try{
        if(i=='submit_button')
          return configurationMap[i](_formBody[i], submitCallback: submit);
        return configurationMap[i](_formBody[i]);
      } on NoSuchMethodError{
        String err = 'A component (' + i + ') used does not exist';
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

  static void buttonAction(Map<String, dynamic> action){
    String actionType = action['action_type'];

    if (actionType == changePage){
      assert(action.containsKey('new_page')); // delegate to a function that checks components structured correctly
      action['new_page']();
    } else if (actionType == getData){

    }
  }

  static Widget createButton(Map _data, {FormSubmitCallback submitCallback}) =>
      CreatableButton(data: _data, submitCallback: submitCallback);

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
    }
    else {
      return MyButton(
          buttonText: data['value'],
          onPressCallback: data['action'] != null ? () =>
              buttonAction(data['action']) : null
      );
    }
  }
}

class FeatureDetailScreen extends StatefulWidget{
  final FeatureModel feature;
  final bool isAdmin;

  FeatureDetailScreen({Key key, this.feature, this.isAdmin}) : super(key: key);

  final Map<String, dynamic> json = {
    'admin': {
      'home': {
        'metadata': {
          'show_back_button': 'false'
        },
        'text': {
          'value': 'hello',
        },
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
      },
      'second': {
        'text': {
          'value': 'second',
        },
        'button': {
          'value': 'second_button',
          'action': {
            'action_type': 'change_page',
            'new_page': 'third', // specify name of new page
          }
        }
      },
      'third': {
        'form': {
          'action': {
            'action_type': 'api',
            'method': 'get',
            'url': '/data_store',
          },
          'body': {
            'input': {
              'type': 'email',
            },
            'submit_button': {
              'value': 'submit',
            }
          }
        }
      },
    },
    'member': {
      'home': {
        'text': {
          'value': 'hi'
        }
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
    final Map<String, dynamic> _newJson = widget.isAdmin ? widget.json['admin'] : widget.json['member'];

    // replace special values and data in configuration data
    assert(_newJson != null);
    assert(_newJson.containsKey('home'));
    assert(_newJson['home'].keys.length > 0);
    final Map<String, dynamic> _replacedJson = _newJson.map(replaceMapValues);

    // if stack is empty, add the first screen
    if (screenStack.isEmpty) screenStack.add(_firstFeatureScreen);

    // load the current screen data
    Map<String, dynamic> _screenData = _replacedJson[screenStack.last];

    final isFirstScreen = screenStack.length == 1;
    if(_screenData['metadata'] != null) {
      // set show back button
      if (!isFirstScreen && _screenData['metadata']['show_back_button'] == 'false') Provider.of<FeatureScreenBackButtonModel>(context).setShowBackButton(false);

      // remove metadata from the data
      _screenData.removeWhere((key, value) => key == 'metadata');
    }

    // create list of widgets from configuration data
    List<Widget> list = _screenData.keys.map<Widget>((i){
      try{
        return configurationMap[i](_screenData[i]);
      } on NoSuchMethodError{
        // inform user of error
        String err = 'A component (' + i + ') used does not exist';
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
                  children: list
              )
            ],
          ),
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        )
    );
  }
}