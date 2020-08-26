import 'package:flutter/material.dart';
import 'package:mega/components/buttons/my_submit_button.dart';
import 'package:mega/components/inputs/my_text_input.dart';
import 'package:mega/components/texts/error_text.dart';
import 'package:mega/screens/home/home_screen.dart';
import 'package:mega/services/api/community_api.dart';
import 'package:mega/services/validators.dart';


class JoinCommunityForm extends StatefulWidget{
  _JoinCommunityFormState createState() => _JoinCommunityFormState();
}

class _JoinCommunityFormState extends State<JoinCommunityForm>{
  final TextEditingController _communityKeyController = TextEditingController();
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
      bool _res = await CommunityAPI.joinCommunities(context, _communityKeyController.text, setErrorText);

      if(_res) Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen())
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          MyTextInput(
            controller: _communityKeyController,
            hintText: 'Community key *',
            validator: (val)=>Validators.exactLengthValidator(val, 10),
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