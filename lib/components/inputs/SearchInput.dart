import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget{
  final TextEditingController controller;

  SearchInput({@required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          hintText: 'search',
          border: OutlineInputBorder()
      ),
    );
  }
}