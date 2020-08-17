import 'package:flutter/material.dart';
import 'package:mega/components/buttons/my_submit_button.dart';
import 'package:mega/components/inputs/dropdown_input.dart';
import 'package:mega/components/inputs/my_text_input.dart';
import 'package:mega/components/texts/error_text.dart';
import 'package:mega/models/response_models/create_community_response_model.dart';
import 'package:mega/screens/home/home_screen.dart';
import 'package:mega/services/api/community_api.dart';
import 'package:mega/services/validators.dart';

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
      if(_res != null) Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen())
      );
    }
  }

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
            validator: Validators.requiredValidator,
          ),
          Container(
            child: DropdownInput(
              dropDownList: <Map<String,String>>[{'value':'EST', 'text':'Estate'}],
              dropDownChangedCallback: changeTypeValue,
              hintText: 'Community type *',
              validator: Validators.requiredValidator,
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