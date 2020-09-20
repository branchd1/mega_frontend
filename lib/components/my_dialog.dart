import 'package:flutter/material.dart';

/// A dialog widget used for popups
class MyDialog extends StatelessWidget{

  /// The main title of the dialog
  final String title;

  /// The subtitle of the dialog
  final String subtitle;

  /// Button widgets on the dialog
  final List<Widget> buttons;

  /// Constructor
  const MyDialog({Key key, @required this.title, @required this.subtitle, this.buttons}) : super(key: key);

  /// Shows the desired dialog on the specified scaffold context
  static void showMyDialog(BuildContext context, String title, String subtitle, {List<Widget> buttons}){
    showDialog<void>(
      context: context,
      barrierDismissible: true, // dismiss when user clicks outside the dialog
      builder: (BuildContext context) {
        return MyDialog(
          title: title,
          subtitle: subtitle,
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