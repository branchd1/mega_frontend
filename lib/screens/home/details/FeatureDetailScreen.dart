import 'package:flutter/material.dart';
import 'package:mega/components/bars/MyAppBars.dart';
import 'package:mega/components/buttons/MyButton.dart';
import 'package:mega/components/buttons/MySubmitButton.dart';
import 'package:mega/components/inputs/MyEmailInput.dart';
import 'package:mega/components/texts/BigText.dart';
import 'package:mega/components/texts/ErrorText.dart';
import 'package:mega/models/FeatureModel.dart';

const Map<String, dynamic> configurationMap = {
  'text': CreatableText.createText,
  'button': CreatableButton.createButton,
  'submit_button': CreatableSubmitButton.createSubmitButton,
  'form': CreatableForm.createForm,
  'input': CreatableInput.createInput,
};

final Map<String, Widget> idToWidgetMap = {};

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
          return configurationMap[i](_formBody[i], submit);
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

class CreatableSubmitButton extends StatelessWidget{
  static const String CHANGE_PAGE='change_page', GET_DATA='get_data';

  final Map data;
  final FormSubmitCallback submitCallback;

  const CreatableSubmitButton({Key key, this.data, this.submitCallback}) : super(key: key);

  static void setButtonAction(Map<String, dynamic> action){
    String actionType = action['action_type'];

    if (actionType == CHANGE_PAGE){
      assert(action.containsKey('new_page')); // delegate to a function that checks components structured correctly
      action['new_page']();
    } else if (actionType == GET_DATA){

    }
  }

  static Widget createSubmitButton(Map _data, FormSubmitCallback submitCallback) =>
      CreatableSubmitButton(data: _data, submitCallback: submitCallback);

  @override
  Widget build(BuildContext context) {
    assert(data['value'] != null);

    return MySubmitButton(
        buttonText: data['value'],
        submitCallback: submitCallback
    );
  }
}

class CreatableButton extends StatelessWidget{
  static const String CHANGE_PAGE='change_page', GET_DATA='get_data';

  final Map data;

  const CreatableButton({Key key, this.data}) : super(key: key);

  static void setButtonAction(Map<String, dynamic> action){
    String actionType = action['action_type'];

    if (actionType == CHANGE_PAGE){
      assert(action.containsKey('new_page')); // delegate to a function that checks components structured correctly
      action['new_page']();
    } else if (actionType == GET_DATA){

    }
  }

  static Widget createButton(Map _data) => CreatableButton(data: _data);

  @override
  Widget build(BuildContext context) {
    assert(data['value'] != null);

    return MyButton(
        buttonText: data['value'],
        onPressCallback: data['action'] != null ? ()=>setButtonAction(data['action']) : null
    );
  }
}

class FeatureDetailScreen extends StatefulWidget{
  final FeatureModel feature;

  FeatureDetailScreen({Key key, this.feature}) : super(key: key);

  @override
  _FeatureDetailScreenState createState()=> _FeatureDetailScreenState();
}

class _FeatureDetailScreenState extends State<FeatureDetailScreen>{

  String currentFeatureScreen = 'home';

  Map<String, dynamic> json = {
    'home': {
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
  };

  MapEntry<String, dynamic> replaceMapValues(String key, dynamic value){
    // recursively replace map values
    if(value is Map){
      value = Map<String, dynamic>.from(value.map(replaceMapValues));
    }

    // do replacement
    if(key == 'new_page' && value is String){
      return MapEntry(key, ()=>setState(()=>{currentFeatureScreen=value}));
    } else {
      return MapEntry(key, value);
    }
  }

  @override
  Widget build(BuildContext context) {
    // replace special values and data in configuration data
    final Map<String, dynamic> _replacedJson = json.map(replaceMapValues);

    // load the current screen data
    Map<String, dynamic> _screenData = _replacedJson[currentFeatureScreen];

    // create list of widgets from configuration data
    List<Widget> list = _screenData.keys.map<Widget>((i){
      try{
        return configurationMap[i](_screenData[i]);
      } on NoSuchMethodError{
        String err = 'A component (' + i + ') used does not exist';
        print(err);
        return ErrorText(err);
      }
    }).toList();

    return Scaffold(
      appBar: MyAppBars.myAppBar5(context),
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