import 'dart:io';

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

    _validators.keys.takeWhile((value) => res == null).forEach((validator){
      if(validator == 'required') {
        res = Validators.requiredValidator(val);
      }

      if(validator == 'min') {
        res = Validators.minLengthValidator(val, _validators['min']);
      }

      if(validator == 'max') {
        res = Validators.maxLengthValidator(val, _validators['max']);
      }

      if(validator == 'exact') {
        res = Validators.exactLengthValidator(val, _validators['max']);
      }

      if(validator == 'number') {
        res = Validators.numberValidator(val);
      }
      
      if(validator == 'max_file_size'){
        res = Validators.fileSizeValidator(File(val), val: double.parse(_validators['max_file_size']));
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