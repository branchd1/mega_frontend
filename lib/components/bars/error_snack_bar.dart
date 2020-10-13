
import 'package:flutter/material.dart';

/// Error bar shown below app when something goes wrong
class ErrorSnackBar extends StatelessWidget{
  /// show the error bar
  static void showErrorSnackBar(BuildContext context){
    Scaffold.of(context).showSnackBar(ErrorSnackBar().build(context));
  }

  @override
  Widget build(BuildContext context) {
    return SnackBar(
        content: Text('Something went wrong'),
        backgroundColor: Colors.red
    );
  }
}