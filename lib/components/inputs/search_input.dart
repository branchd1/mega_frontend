import 'package:flutter/material.dart';
import 'package:mega/services/callback_types.dart';

/// Widget representing search bar
class SearchInput extends StatelessWidget{

  /// Callback when search bar value changes
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