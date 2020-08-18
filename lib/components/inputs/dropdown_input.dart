import 'package:flutter/material.dart';
import 'package:mega/services/callback_types.dart';

class DropdownInput extends StatelessWidget{
  final List<Map<String,String>> dropDownList;
  final DropDownChangedCallback dropDownChangedCallback;
  final String hintText;
  final ValidatorCallback validator;

  const DropdownInput({Key key, this.dropDownList, this.dropDownChangedCallback, this.hintText, this.validator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButtonFormField<String>(
        items: dropDownList.map(
          (Map<String,String> elem) => DropdownMenuItem<String>(
            value: elem['value'],
            child: new Text(elem['text']),
          )
        ).toList(),
        onChanged: dropDownChangedCallback,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
        ),
        validator: validator,
      ),
    );
  }
}