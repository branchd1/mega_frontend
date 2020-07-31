
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

SnackBar showErrorSnackBar(BuildContext context){
  Scaffold.of(context).showSnackBar(
    SnackBar(
      content: Text('Something went wrong'),
      backgroundColor: Colors.red
    )
  );
}