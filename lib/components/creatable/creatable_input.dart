import 'package:flutter/material.dart';
import 'package:mega/components/inputs/my_email_input.dart';
import 'package:mega/components/inputs/my_text_input.dart';
import 'package:mega/services/validators.dart';

class CreatableInput extends StatelessWidget{
  final List<String> inputTypes = ['email', 'text'];
  final Map<String, dynamic> data;
  final TextEditingController controller;

  CreatableInput({Key key, this.data, this.controller}) : super(key: key);

  static Widget createInput(Map<String, dynamic> data, {TextEditingController controller}){
    return CreatableInput(data: data, controller: controller,);
  }

  String validator(String val) {
    Map<String, dynamic> _validators = data['validators'];
    String res;

    _validators.keys.takeWhile((value) => res == null).forEach((validator){
      if(validator.contains('required')) {
        res = Validators.requiredValidator(val);
      }

      if(validator.contains('min')) {
        int length = int.parse(validator.split('_')[1]);
        res = Validators.minLengthValidator(val, length);
      }

      if(validator.contains('max')) {
        int length = int.parse(validator.split('_')[1]);
        res = Validators.maxLengthValidator(val, length);
      }

      if(validator.contains('exact')) {
        int length = int.parse(validator.split('_')[1]);
        res = Validators.exactLengthValidator(val, length);
      }
    });

    return res;
  }

  @override
  Widget build(BuildContext context) {
    assert(data['type'] != null);
    assert(inputTypes.contains(data['type']));

    if(data['type'] == 'email') {
      return MyEmailInput(controller: controller,);
    }

    if(data['type'] == 'text') {
      return MyTextInput(
        controller: controller,
        hintText: data.containsKey('hint') ? data['hint'] : null,
        validator: validator,
      );
    }
//    not yet implemented
//    if(data['type'] == 'password') return MyPasswordInput();
//    if(data['type'] == 'dropdown') return DropdownInput();

      return Container();
  }
}