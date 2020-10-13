import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mega/components/texts/error_text_plain.dart';
import 'package:mega/services/api/feature_dev_api.dart';
import 'package:mega/services/constants.dart';

/// Mega form component
class CreatableForm extends StatefulWidget{
  /// The component map
  final Map data;

  const CreatableForm({Key key, @required this.data}) : super(key: key);

  /// Create Mega form
  static Widget createForm(Map _data) => CreatableForm(data: _data);

  _CreatableFormState createState() => _CreatableFormState();
}

class _CreatableFormState extends State<CreatableForm>{

  /// Map of controllers for form inputs
  Map<TextEditingController, String> _controllersMap =
  Map<TextEditingController, String>();

  /// Globally unique form key
  final _formKey = GlobalKey<FormState>();

  /// Callback when form is submitted
  void submit({VoidCallback doAfter}) async {
    if (_formKey.currentState.validate()){
      // get form action map
      Map<String, dynamic> _formActionMap = widget.data['action'];

      // create map from form values using controllers
      Map<String, String> formValuesMap = Map<String, String>.from(_controllersMap.map((key, value) => MapEntry(value, key.text)));

      // saving to data store
      if (_formActionMap['action_type'] == 'save'){
        // send data to api and do something with it
        if (_formActionMap['method'] == 'post'){
          // get tag
          assert(_formActionMap.containsKey('tag') && _formActionMap['tag'] != null);
          String tag = _formActionMap['tag'];

          // get access level
          String access = formValuesMap.containsKey('access') ? formValuesMap['access'] : null;

          // send map for storage in server
          if(_formActionMap.containsKey('multipart') &&  (_formActionMap['multipart'] as List).isNotEmpty){

            List<Map<String, dynamic>> listOfFileFields = List<Map<String, dynamic>>.from(_formActionMap['multipart']);

            for(Map<String, dynamic> fileFieldList in listOfFileFields){
              formValuesMap[fileFieldList['field']] = await FeatureDevAPI.uploadImageToDataStore(context, File(formValuesMap[fileFieldList['field']]));
            }

            await FeatureDevAPI.saveToDataStore(
              context,
              data: formValuesMap,
              access: access,
              tag: tag
            );
          }
          // incomplete - do something with return data above
        } else {
          throw ('action method must be get, post, put, or delete');
        }
      }

      // do something after
      if (doAfter != null) doAfter();
    }
  }

  @override
  Widget build(BuildContext context) {
    // validate component data
    assert(widget.data['body'] != null);
    assert(widget.data['action'] != null);

    List<Map<String, dynamic>> _formBody = widget.data['body'];

    // map form inner components map values to Mega components
    List<Widget> list = _formBody.map<Widget>((component){
      final String _componentName = component.keys.toList()[0];
      try{
        if(_componentName=='button') {
          return configurationMap[_componentName](component[_componentName], callback: submit);
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
        return ErrorTextPlain(err);
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