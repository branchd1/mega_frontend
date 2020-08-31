
import 'package:flutter/material.dart';
import 'package:mega/components/buttons/my_button.dart';

class MyDialog{
  static void showMyDialog(BuildContext context, String text, String subtext, {List<Widget> buttons}){
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
          actions: buttons,
        );
      },
    );
  }
}