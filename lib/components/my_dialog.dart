
import 'package:flutter/material.dart';

/// A dialog used for popups
class MyDialog extends StatelessWidget{

  /// The main title of the dialog
  final String title;

  /// The subtitle of the dialog
  final String subtitle;

  /// Button widgets on the dialog
  final List<Widget> buttons;

  /// Constructor
  const MyDialog({Key key, this.title, this.subtitle, this.buttons}) : super(key: key);

  /// Shows the desired dialog on the specified scaffold context
  static void showMyDialog(BuildContext context, String text, String subtext, {List<Widget> buttons}){
    showDialog<void>(
      context: context,
      barrierDismissible: true, // dismiss when user clicks outside the dialog
      builder: (BuildContext context) {
        return MyDialog(
          title: text,
          subtitle: subtext,
          buttons: buttons
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: SelectableText(title),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            SelectableText(subtitle),
          ],
        ),
      ),
      actions: buttons,
    );
  }
}