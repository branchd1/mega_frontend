import 'package:flutter/material.dart';
import 'package:mega/services/callback_types.dart';

/// Drop down input widget
class DropdownInput extends StatelessWidget{
  /// List of values for the users to select from
  final List<dynamic> dropDownList;

  /// Callback when the dropdown value changes
  final DropDownChangedCallback dropDownChangedCallback;

  /// The input placeholder
  final String hintText;

  /// Callback to validate the value chosen
  final ValidatorCallback validator;

  const DropdownInput({Key key, @required this.dropDownList, @required this.dropDownChangedCallback,
    @required this.hintText, this.validator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButtonFormField<String>(
        items: dropDownList.map(
          // iterate {dropDownList} to create {DropdownMenuItem}
          (dynamic elem){
            return DropdownMenuItem<String>(
              value: elem._id.toString(),
              child: new Text(elem.value),
            );
          }
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