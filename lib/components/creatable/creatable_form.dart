import 'package:flutter/material.dart';
import 'package:mega/components/texts/error_text.dart';
import 'package:mega/services/api/feature_dev_api.dart';
import 'package:mega/services/constants.dart';

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

          // incomplete - do something with return data above
        } else if (_formActionMap['method'] == 'post'){
          // get tag
          assert(_formActionMap.containsKey('tag') && _formActionMap['tag'] != null);
          String tag = _formActionMap['tag'];

          // get access level
          String access = formValuesMap.containsKey('access') ? formValuesMap['access'] : null;

          // send map for storage in server
          FeatureDevAPI.saveToDataStore(
              context,
              data: formValuesMap,
              access: access,
              tag: tag
          );

          // incomplete - do something with return data above
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
        } else {
          return configurationMap[_componentName](component[_componentName]);
        }
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