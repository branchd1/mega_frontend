import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mega/components/buttons/my_button.dart';
import 'package:mega/components/buttons/my_submit_button.dart';
import 'package:mega/components/my_dialog.dart';
import 'package:mega/components/inputs/dropdown_input.dart';
import 'package:mega/components/inputs/my_file_input.dart';
import 'package:mega/components/inputs/my_text_input.dart';
import 'package:mega/components/texts/error_text_plain.dart';
import 'package:mega/components/texts/error_text_with_icon.dart';
import 'package:mega/models/community_type_model.dart';
import 'package:mega/models/response_models/create_community_response_model.dart';
import 'package:mega/screens/home/home_screen.dart';
import 'package:mega/services/api/community_api.dart';
import 'package:mega/services/validators.dart';

class CreateCommunityForm extends StatefulWidget{
  _CreateCommunityFormState createState() => _CreateCommunityFormState();
}

class _CreateCommunityFormState extends State<CreateCommunityForm>{
  final TextEditingController _communityNameController = TextEditingController();
  final TextEditingController _communityPicturePathController = TextEditingController();
  String _communityTypeControllerSimulator;
  final _formKey = GlobalKey<FormState>();
  String _errorText;

  void setErrorText(text){
    setState(() {
      _errorText = text;
    });
  }

  Future<void> submit() async {
    if (_formKey.currentState.validate()){
      // create community
      CreateCommunityResponseModel _res = await CommunityAPI.createCommunity(context, _communityNameController.text, _communityTypeControllerSimulator, _communityPicturePathController.text, setErrorText);

      String _dialogTitle = 'Save your community key';

      String _dialogText = 'Your community key is ' + _res.key +
          '.\n\nShare this key to members to join your community.' +
          '\n\nTo restrict strangers from joining, keep this key private.';

      Widget _dialogButton = MyButton(
        buttonText: 'ok',
        onPressCallback: (){
          if(_res != null) Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen())
          );
        }
      );

      List<Widget> _dialogButtons = [_dialogButton];

      MyDialog.showMyDialog(context, _dialogTitle, _dialogText, buttons: _dialogButtons);
    }
  }

  void changeTypeValue(String val){
    _communityTypeControllerSimulator = val;
  }

  @override
  Widget build(BuildContext context) {
    Future<List<CommunityTypeModel>> _typeList = CommunityAPI.getCommunityTypes(context);
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          MyTextInput(
            controller: _communityNameController,
            hintText: 'Community name *',
            validator: Validators.requiredValidator,
          ),
          FutureBuilder<List<CommunityTypeModel>>(
            future: _typeList,
            builder: (BuildContext context, AsyncSnapshot<List<CommunityTypeModel>> snapshot) {
              Widget _widget;
              if(snapshot.hasData){
                _widget = Container(
                  child: DropdownInput(
                    dropDownList: snapshot.data,
                    dropDownChangedCallback: changeTypeValue,
                    hintText: 'Community type *',
                    validator: Validators.requiredValidator,
                  ),
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                );
              } else if (snapshot.hasError){
                _widget = ErrorTextPlain('Cannot retrieve community types');
              } else {
                _widget = CircularProgressIndicator();
              }
              return _widget;
            },
          ),
          Container(
            child: MyFileInput(
              hintText: 'upload picture *',
              controller: _communityPicturePathController,
              validator: Validators.requiredValidator,
            ),
            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: MySubmitButton(
              buttonText: 'Submit',
              submitCallback: submit,
            )
          ),
          if(_errorText!=null) Align(
            alignment: Alignment.bottomLeft,
            child: ErrorTextPlain(_errorText),
          )
        ],
      )
    );
  }
}