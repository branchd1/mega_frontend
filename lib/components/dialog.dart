
import 'package:flutter/material.dart';

class MyDialog{
  static void showMyDialog(BuildContext context, String text, String subtext){
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(text),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(subtext),
              ],
            ),
          ),

        );
      },
    );
  }
}