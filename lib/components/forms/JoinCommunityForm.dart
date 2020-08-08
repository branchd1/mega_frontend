import 'package:flutter/material.dart';
import 'package:mega/components/buttons/MySubmitButton.dart';
import 'package:mega/components/inputs/MyTextInput.dart';
import 'package:mega/components/texts/ErrorText.dart';
import 'package:mega/screens/home/HomeScreen.dart';
import 'package:mega/services/api/CommunityAPI.dart';


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

  String validateKey(String text)=> text.length != 10 ?  'Key should be exactly 10 characters' : null;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          MyTextInput(
            controller: _communityKeyController,
            hintText: 'Community key *',
            validator: validateKey,
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