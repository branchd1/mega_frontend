import 'package:flutter/material.dart';
import 'package:mega/components/buttons/MySubmitButton.dart';
import 'package:mega/components/inputs/DropdownInput.dart';
import 'package:mega/components/inputs/MyTextInput.dart';
import 'package:mega/components/texts/ErrorText.dart';
import 'package:mega/models/response/CreateCommunityResponseModel.dart';
import 'package:mega/services/api/CommunityAPI.dart';

class CreateCommunityForm extends StatefulWidget{
  _CreateCommunityFormState createState() => _CreateCommunityFormState();
}

class _CreateCommunityFormState extends State<CreateCommunityForm>{
  final TextEditingController _communityNameController = TextEditingController();
  String _communityTypeControllerSimulator;
  final _formKey = GlobalKey<FormState>();
  String _errorText;

  void setErrorText(text){
    setState(() {
      _errorText = text;
    });
  }

  void submit() async {
    if (_formKey.currentState.validate()){
      // check email
      CreateCommunityResponseModel _res = await CommunityAPI.createCommunity(context, _communityNameController.text, _communityTypeControllerSimulator, setErrorText);

      // check successful
      if(_res != null) Navigator.pop(context);
    }
  }

  String validateName(String text)=> text == null ? 'Name cannot be empty' : null;
  String validateType(String text)=> text == null ? 'A type must be chosen' : null;

  void changeTypeValue(String val){
    _communityTypeControllerSimulator = val;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          MyTextInput(
            controller: _communityNameController,
            hintText: 'Community name *',
            validator: validateName,
          ),
          Container(
            child: DropdownInput(
              dropDownList: <Map<String,String>>[{'value':'EST', 'text':'Estate'}],
              dropDownChangedCallback: changeTypeValue,
              hintText: 'Community type *',
              validator: validateType,
            ),
            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: MySubmitButton(
              buttonText: 'Go',
              submitCallback: submit,
            )
          ),
          if(_errorText!=null) Align(
            alignment: Alignment.bottomLeft,
            child: ErrorText(_errorText),
          )
        ],
      )
    );
  }
}