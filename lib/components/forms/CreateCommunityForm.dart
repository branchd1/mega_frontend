import 'package:flutter/material.dart';
import 'package:mega/components/MySubmitButton.dart';
import 'package:mega/components/inputs/DropdownInput.dart';
import 'package:mega/components/inputs/MyTextInput.dart';

class CreateCommunityForm extends StatefulWidget{
  _CreateCommunityFormState createState() => _CreateCommunityFormState();
}

class _CreateCommunityFormState extends State<CreateCommunityForm>{
  final TextEditingController _communityNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void submit() async {
    if (_formKey.currentState.validate()){
      // check email
//      EmailExistsResponseModel _res = await AuthAPI.checkEmailExists(context, _emailController.text);
//
//      // check successful
//      if(_res!= null && _res.exists){
//        Navigator.push(
//          context,
//          MaterialPageRoute(builder: (context) => LoginScreen(email: _emailController.text)),
//        );
//      } else if (_res!= null) {
//        Navigator.push(
//          context,
//          MaterialPageRoute(builder: (context) => RegisterScreen(email: _emailController.text)),
//        );
//      }
    }
  }

  String validateName(String text)=> text == null ? 'Name cannot be empty' : null;
  String validateType(String text)=> text == null ? 'A type must be chosen' : null;

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
            dropDownList: <String>['bar', 'estate'],
            dropDownChangedCallback: (val){},
            hintText: 'Community type *',
            validator: validateType
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
        ],
      )
    );
  }
}