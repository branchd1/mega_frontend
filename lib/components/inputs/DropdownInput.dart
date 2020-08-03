import 'package:flutter/material.dart';

typedef DropDownChangedCallback(String val);
typedef Validator(String val);

class DropdownInput extends StatelessWidget{
  final List<String> dropDownList;
  final DropDownChangedCallback dropDownChangedCallback;
  final String hintText;
  final Validator validator;

  const DropdownInput({Key key, this.dropDownList, this.dropDownChangedCallback, this.hintText, this.validator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      items: dropDownList.map(
        (String elem) => DropdownMenuItem<String>(
          value: elem,
          child: new Text(elem),
        )
      ).toList(),
      onChanged: dropDownChangedCallback,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder()
      ),
      validator: validator,
    );
  }
}