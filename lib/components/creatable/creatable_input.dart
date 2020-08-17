import 'package:flutter/material.dart';
import 'package:mega/components/inputs/my_email_input.dart';

class CreatableInput extends StatelessWidget{
  final List<String> inputTypes = ['email', 'text'];
  final Map data;
  final TextEditingController controller;

  CreatableInput({Key key, this.data, this.controller}) : super(key: key);

  static Widget createInput(Map _data, {TextEditingController controller}){
    return CreatableInput(data: _data, controller: controller,);
  }

  @override
  Widget build(BuildContext context) {
    assert(data['type'] != null);
    assert(inputTypes.contains(data['type']));

    if(data['type'] == 'email') return MyEmailInput(controller: controller,);

//    not yet implemented
//    if(data['type'] == 'text') return MyTextInput();
//    if(data['type'] == 'password') return MyPasswordInput();
//    if(data['type'] == 'dropdown') return DropdownInput();

    return Container();
  }
}