
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorSnackBar{
  static void showErrorSnackBar(BuildContext context){
    Scaffold.of(context).showSnackBar(
        SnackBar(
            content: Text('Something went wrong'),
            backgroundColor: Colors.red
        )
    );
  }
}