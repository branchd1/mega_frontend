import 'package:flutter/material.dart';

typedef void OnChangeCallback(String val);

class SearchInput extends StatelessWidget{
  final OnChangeCallback onChangeCallback;

  SearchInput({@required this.onChangeCallback});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          hintText: 'search',
          border: OutlineInputBorder()
      ),
      onChanged: onChangeCallback,
    );
  }
}