import 'package:flutter/material.dart';
import 'package:mega/components/inputs/my_email_input.dart';
import 'package:mega/components/inputs/my_file_input.dart';
import 'package:mega/components/inputs/my_text_input.dart';
import 'package:mega/services/validators.dart';

class CreatableInput extends StatelessWidget{
  final List<String> inputTypes = ['email', 'text', 'file'];
  final Map<String, dynamic> data;
  final TextEditingController controller;

  CreatableInput({Key key, this.data, this.controller}) : super(key: key);

  static Widget createInput(Map<String, dynamic> data, {TextEditingController controller}){
    return CreatableInput(data: data, controller: controller,);
  }

  String validator(String val) {
    // convert validator keys to enum

    Map<String, dynamic> _validators = data['validators'];
    String res;

    if(data['type'] == 'file') assert(_validators.keys.isEmpty || _validators.keys.length == 1 && _validators.containsKey('required'));

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

      if(validator.contains('number')) {
        res = Validators.numberValidator(val);
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

    if(data['type'] == 'file') {
      return MyFileInput(
        hintText: data.containsKey('hint') ? data['hint'] : null,
        validator: validator,
        controller: controller,
      );
    }
//    not yet implemented
//    if(data['type'] == 'password') return MyPasswordInput();
//    if(data['type'] == 'dropdown') return DropdownInput();

      return Container();
  }
}