import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return AppBar(
      backgroundColor: Colors.white,
      actions: <Widget>[
        Image.asset('assets/img/logo/small/logo.png')
      ],
    );
  }
}