import 'package:flutter/material.dart';

typedef void OnChangeCallback(String val);

class SearchInput extends StatelessWidget{
  final OnChangeCallback onChangeCallback;

  SearchInput({@required this.onChangeCallback});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        decoration: InputDecoration(
            hintText: 'search',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
        ),
        onChanged: onChangeCallback,
      ),
    );
  }
}